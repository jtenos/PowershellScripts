# This script will retrieve all mkv files in the "input" directory
# and convert them to mp4, placing the new mp4 files in the "converted"
# directory

# You need the HandbrakeCLI application: https://handbrake.fr/downloads2.php

# Quality 18 seems to be good for DVD video. HD you would want better quality (lower number is better).

$InputDir = Resolve-Path "input"
$OutputDir = Resolve-Path "converted"
$HandbrakeExe = "C:\HandbrakeCLI\HandbrakeCLI.exe"

$Files = Get-ChildItem -Path $InputDir -Filter *.mkv
$Files | ForEach-Object {
    $FileName = $_.FullName
    $Mp4FileName = $_.Name -replace "\.mkv$", ".mp4"
    # Write-Output $FileName
    
    $ConvertedFileName = Join-Path -Path $OutputDir -ChildPath $Mp4FileName
    # Write-Output $ConvertedFileName

    Start-Process -FilePath $HandbrakeExe -ArgumentList "--input `"$FileName`" --output `"$ConvertedFileName`" --format av_mp4 --quality 18 --subtitle 1 --subtitle-burn" -Wait
}
