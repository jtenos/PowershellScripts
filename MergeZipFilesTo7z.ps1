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
