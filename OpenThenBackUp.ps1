# Opens a file for editing in a particular editor, then once that process is closed,
# copies the file to a location for backup.

$NowFormatted = Get-Date -Format "yyyyMMddHHmmssfff"
$EditorExe = "C:\Program Files\Microsoft Office\root\Office16\MSACCESS.EXE"
$DocFile = "C:\Users\MyName\MyDatabase.accdb"
$BackupDir = "C:\Users\MyName\OneDrive\__ToBackup"
$BackupFileName = Join-Path $BackupDir "MyDatabase_$($NowFormatted).bak.accdb"

Start-Process -FilePath $EditorExe -ArgumentList "`"$($DocFile)`"" -Wait
Copy-Item -Path $DocFile -Destination $BackupFileName
