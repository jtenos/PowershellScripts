# This script will retrieve all zip files in a directory, unzip them one at a time into new directories,
# then add those directories to a .7z file. Useful if you have a collection of zip files with mostly the same
# contents, where you'll benefit from combining them together, but you don't have enough disk space to unzip
# all of them at once.

# Set these two constant values:

$SevenZipExe = "C:\Program Files\7-zip\7z.exe"
$Dir = "C:\temp\je"

$ZipFiles = Get-ChildItem -Path "$($dir)\*" -Include "*.zip"
$NowFormatted = Get-Date -Format "yyyyMMddHHmmssfff"
$RandNum = Get-Random -Minimum 1000000 -Maximum 9999999
$OutputFile = "$($dir)\output_$($NowFormatted)_$($RandNum).7z"

$ZipFiles | ForEach-Object {
    $ZipFileName = $_.FullName
    $DirName = $_.FullName -replace "\.zip$", ""
    Start-Process -FilePath $SevenZipExe -ArgumentList "x `"$ZipFileName`" -o`"$DirName`"" -Wait
    Start-Process -FilePath $SevenZipExe -ArgumentList "a `"$OutputFile`" `"$DirName`"" -Wait
    Remove-Item -Recurse -Path $DirName
}
