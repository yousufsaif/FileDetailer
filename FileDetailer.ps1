# PowerShell Script with User Options for File Detail Extraction and Advanced Sorting
# Author: https://github.com/yousufsaif


# Function to get the file hash
function Get-FileHashString {
    param([String]$filePath)
    try {
        $hash = Get-FileHash -Algorithm SHA256 -Path $filePath
        return $hash.Hash
    } catch {
        return "Error in hashing"
    }
}

# Function to get digital signature information
function Get-SignatureStatus {
    param([String]$filePath)
    try {
        $signature = Get-AuthenticodeSignature $filePath
        return $signature.Status
    } catch {
        return "Not Signed or Error"
    }
}

# User choice for folder scope
Write-Host "Select the scope for file details:"
Write-Host "1. Current Folder Only"
Write-Host "2. Current Folder and All Subfolders"
$folderScopeChoice = Read-Host "Enter your choice (1 or 2)"

# Get files based on user choice
$files = switch ($folderScopeChoice) {
    "1" { Get-ChildItem -File }
    "2" { Get-ChildItem -File -Recurse }
    Default { Write-Host "Invalid choice. Defaulting to Current Folder Only."; Get-ChildItem -File }
}

# Array to hold file details
$fileDetails = @()

foreach ($file in $files) {
    $shellObject = New-Object -ComObject Shell.Application
    $shellFolder = $shellObject.Namespace($file.DirectoryName)
    $shellFile = $shellFolder.ParseName($file.Name)

    $details = New-Object PSObject -Property @{
        Hash = Get-FileHashString $file.FullName
        Name = $file.Name
        Type = $file.Extension
        Size = $file.Length
        CreationTime = $file.CreationTime
        LastWriteTime = $file.LastWriteTime
        LastAccessTime = $file.LastAccessTime
        Owner = (Get-Acl $file.FullName).Owner
        DigitalSignatureStatus = Get-SignatureStatus $file.FullName
        Title = $shellFolder.GetDetailsOf($shellFile, 21)  # Title (for documents)
        Author = $shellFolder.GetDetailsOf($shellFile, 20) # Author
        Comments = $shellFolder.GetDetailsOf($shellFile, 24) # Comments
        Path = $file.FullName
    }

    $fileDetails += $details
}

# User choice for sorting option
Write-Host "Select the sorting option for the CSV file:"
Write-Host "1. Hash"
Write-Host "2. File Names"
Write-Host "3. Date and Time of Last Modification"
Write-Host "4. Date and Time of Creation"
Write-Host "5. Path of the Containing Folder"
$sortingChoice = Read-Host "Enter your choice (1-5)"

# Sort the details based on user choice
$sortedDetails = switch ($sortingChoice) {
    "1" { $fileDetails | Sort-Object Hash }
    "2" { $fileDetails | Sort-Object Name }
    "3" { $fileDetails | Sort-Object LastWriteTime -Descending }
    "4" { $fileDetails | Sort-Object CreationTime -Descending }
    "5" { $fileDetails | Sort-Object Path }
    Default { Write-Host "Invalid choice. Defaulting to sorting by Hash."; $fileDetails | Sort-Object Hash }
}

# Output the sorted details to a CSV file
$sortedDetails | Export-Csv -Path "./SortedFileDetails.csv" -NoTypeInformation

# Display the output file path
Write-Host "Sorted file details exported to SortedFileDetails.csv in the current directory."
