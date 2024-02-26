# Get all disks that do not have partitions
$disks = Get-Disk | Where-Object { $_.PartitionStyle -eq 'RAW' }

# Create partitions with maximum size for each disk
foreach ($disk in $disks) {
    $size = $disk.Size / 1GB
    $partition = New-Partition -DiskNumber $disk.Number -UseMaximumSize -AssignDriveLetter
    Format-Volume -Partition $partition -DriveLetter $partition.DriveLetter -FileSystem NTFS -NewFileSystemLabel 'Data' -Confirm:$false
    Write-Output "Partition and format completed for disk $($disk.Number) with $($size) GB"
}
