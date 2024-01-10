# FileDetailer

This PowerShell script is designed to extract detailed information about files in a specified directory. Users can choose to scan the current folder only or include subfolders. The script outputs a CSV file with detailed information about each file, which can be sorted based on user preference.

## Features

- Extracts various file details including file hash, digital signature status, basic metadata, and file system information.
- User option to scan either the current folder only or include all subfolders.
- Allows sorting of the output CSV file based on file hash, name, last modification date, creation date, or file path.

## How to Use

1. **Run the Script**: Open PowerShell in the directory containing the files you want to analyze. Copy and paste the script and run it. Or (alternatively), you can place the `ps1` file in the target directory, right-click on it, then choose to `Run` the script.
2. **Select Folder Scope**: When prompted, choose:
   - `1` for the current folder only.
   - `2` for the current folder and all subfolders.
3. **Choose Sorting Option**: When prompted, choose the sorting option for the CSV output by entering the corresponding number:
   - `1` for sorting by Hash.
   - `2` for sorting by File Names.
   - `3` for sorting by Date and Time of Last Modification.
   - `4` for sorting by Date and Time of Creation.
   - `5` for sorting by Path of the Containing Folder.
4. **Output**: The script will create a sorted CSV file named `SortedFileDetails.csv` in the current directory.

## Output File Format

The CSV file (`FileDetails.csv`) will include the following columns:

- `Hash`: SHA256 hash of the file.
- `Name`: Name of the file.
- `Type`: File extension.
- `Size`: Size of the file in bytes.
- `CreationTime`: File creation time.
- `LastWriteTime`: Last modification time of the file.
- `LastAccessTime`: Last access time of the file.
- `Owner`: Owner of the file.
- `DigitalSignatureStatus`: Status of the digital signature.
- `Title`: Title of the file (if applicable).
- `Author`: Author of the file (if applicable).
- `Comments`: Any comments associated with the file.
- `Path`: Full path of the file.

## Requirements

- PowerShell 5.0 or later.
- Windows environment.

## Limitations

- The script's ability to extract certain types of metadata (like EXIF data, embedded objects in documents) is limited.
- The accuracy of the details like digital signatures depends on the file type and the presence of such metadata.

## License

This script is provided "as is", without warranty of any kind, express or implied. Use it at your own risk.

## Author

github.com/yousufsaif

## Contributions

Contributions are welcome. Please submit pull requests or issues through GitHub.
