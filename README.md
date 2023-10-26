# Browser Export to KeePass Converter

## Overview
This PowerShell script is designed to convert Firefox and Chrome credential exports into a format compatible with the KeePass Generic CSV Import feature. With this script, you can easily import your saved browser passwords into KeePass.

## Prerequisites
PowerShell
### How it Works
Place your exported .csv credential files from Firefox or Chrome into a folder named input.

If the input folder doesn't exist, the script will create it and show a message asking you to place your .csv files there.

Run the PowerShell script.

The script reads each .csv file, processes it line-by-line, and converts it into the required format for KeePass.

Lines containing android:// are ignored during the conversion.
These are credentials associated with android devices.

The converted .csv files are saved in a folder named output with the prefix keepass_.
If the output folder doesn't exist, the script will create it.

A message will display the number of credentials converted for each file and the total credentials converted for all files.

## Usage
Clone or download this repository, if downloaded, unzip it somewhere.

Export your credentials to CSV via Google Password Manager or Firefox Credential Manager.

Place your .csv credential exports into the INPUT folder.

Run the PowerShell script: .\run.ps1

Find the converted files in the output folder and import them using KeePass's Generic CSV Import feature.

This works for Chrome and Firefox imports, the INPUT folder can contain multiple files, it will generate an output file for each input file.
The output files will have the same name as the input file, with the "keepass_" prefix.
The tool works completely offline.