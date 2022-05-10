# This script will retrieve all files in the "input" directory
# and encrypt them, placing the encrypted files in the "output"
# directory with a GUID file name

# This assumes you've installed GnuPG: https://gpg4win.org/download.html

$InputDir = Resolve-Path "input"
$OutputDir = Resolve-Path "output"
$GpgExe = "C:\Program Files (x86)\GnuPG\bin\gpg.exe"

$Files = Get-ChildItem -Path $InputDir
$Files | ForEach-Object {
    $FileName = $_.FullName
    # Write-Output $FileName
    $GUID = New-Guid
    $EncryptedFileName = Join-Path -Path $OutputDir -ChildPath $GUID.ToString("N")
    # Write-Output $EncryptedFileName
    Start-Process -FilePath $GpgExe -ArgumentList "--batch --symmetric --passphrase MY_PASSPHRASE_GOES_HERE --cipher-algo aes256 --compress-algo 0 --output `"$EncryptedFileName`" `"$FileName`"" -Wait
    Write-Output "$($GUID.ToString("N"))`t$($_.Name)"
}
