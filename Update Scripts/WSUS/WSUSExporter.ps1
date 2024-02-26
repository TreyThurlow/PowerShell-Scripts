# check for administrator privileges
if(-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "This script requires administrator privileges. Please run this script as an administrator."
    return
}

# set source and destination paths
$sourceDrive = "C:\"
$destinationDrive = "\\SERVER\Groups\NPES\WSUSTransfer\"
$DestinationFolder = "WSUSCopy"
$destinationZip = "WSUSContent.zip"

# create backup of data
Write-Progress -Activity "Creating backup of data..." -PercentComplete 0
robocopy $sourceDrive "$destinationDrive\$DestinationFolder" /E /NFL /NDL /NJH /NJS /nc /ns /np /W:0
Write-Progress -Activity "Creating backup of data..." -PercentComplete 100

# compress data and save to destination
Write-Progress -Activity "Compressing data..." -PercentComplete 0
Compress-Archive -Path "$destinationDrive\$DestinationFolder" -DestinationPath "$destinationDrive\$destinationZip" -CompressionLevel Optimal -Update

#Deletes the copied items from WSUS Transfer Directory
Remove-Item -Path "$destinationDrive\$DestinationFolder" -Recurse -Force

# set metadata file name and location
$metadataFile = "wsusmetadata.xml.gz"
$metadataPath = "$destinationDrive\$metadataFile"

# export WSUS metadata
$wsusutil = "C:\Program Files\Update Services\Tools\wsusutil.exe"
Write-Progress -Activity "Exporting WSUS metadata..." -PercentComplete 0
& $wsusutil export $metadataPath export.log
Write-Progress -Activity "Exporting WSUS metadata..." -PercentComplete 100

# display success message
Write-Host "Backup and metadata export complete. Files saved to $destinationDrive."
