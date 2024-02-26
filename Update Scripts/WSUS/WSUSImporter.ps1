#Requires -Version 3.0
#Requires -RunAsAdministrator

# Get all CD/DVD drives using WMI
$drives = Get-WmiObject Win32_CDROMDrive

# Filter out the DVD drive and identify the Blu-ray drive
foreach ($drive in $drives) {
    if ($drive.MediaType -eq "DVD-ROM") {
        continue
    }

    # Get the drive letter of the Blu-ray drive
    $driveLetter = ($drive.PNPDeviceID -split '\\')[2]
    break
}

if (!($driveLetter)) {
    Write-Error "Blu-ray drive not found."
    exit
}

# Specify the destination folder
$DestinationFolder = "C:\Users\Username\Documents\Blu-rayContents"

# Copy the contents of the Blu-ray disc to the destination folder
$TotalItems = (Get-ChildItem $driveLetter\ -Recurse | Measure-Object).Count
$CurrentItem = 0

# Create progress bar
$Progress = New-Object -TypeName System.Windows.Forms.ProgressBar
$Progress.Minimum = 0
$Progress.Maximum = $TotalItems
$Progress.Value = $CurrentItem
$Progress.Show()

# Copy each item and update the progress bar
Get-ChildItem $driveLetter\ -Recurse | ForEach-Object {
    $CurrentItem++
    $Progress.Value = $CurrentItem
    
    if ($_.PSIsContainer) {
        $TargetFolder = Join-Path $DestinationFolder $_.FullName.Substring($driveLetter.Length)
        if (!(Test-Path $TargetFolder)) {
            New-Item $TargetFolder -ItemType Directory | Out-Null
        }
    } else {
        $TargetFile = Join-Path $DestinationFolder $_.FullName.Substring($driveLetter.Length)
        Copy-Item $_.FullName $TargetFile
    }
}

# Close progress bar
$Progress.Dispose()

# Import the export.cab file using wsusutil.exe
$WSUSUTIL = "C:\Program Files\Update Services\Tools\wsusutil.exe"
$ExportCabFile = Join-Path $DestinationFolder "export.cab"
$ImportLogFile = Join-Path $DestinationFolder "import.log"
& $WSUSUTIL import $ExportCabFile $ImportLogFile
