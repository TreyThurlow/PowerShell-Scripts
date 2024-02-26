# specify the path of the text file containing the list of computer names
$computersFilePath = "C:\Computers.txt"

# get the list of computers from the text file
$computers = Get-Content $computersFilePath

# define an empty array to store the results
$results = @()

# loop through all the computers in the list
foreach ($computer in $computers) {
    Write-Host "Processing computer $computer ..."

    try {
        $disks = Get-WmiObject -Class Win32_DiskDrive -ComputerName $computer

        #iterate over each disk
        foreach ($disk in $disks) {
            # get the partition style
            $partitionStyle = $disk.PartitionStyle

            #add the result to the results array
            $result = [PSCustomObject]@{
                ComputerName = $computer
                DiskName = $disk.DeviceID
                PartitionStyle = $partitionStyle
            }

            $results += $result
        }
    } catch {
        #if there was an error retrieving the disk information from the computer
        Write-Warning "Could not retrieve disk information from computer $computer. $($error[0].Exception.Message)"
    }
}

#export the results to a CSV file
$results | Export-Csv -Path "C:\PartitionStyle.csv" -NoTypeInformation

#display a message to confirm that the export was successful
Write-Host "Partition style information for all disks has been exported to C:\PartitionStyle.csv"
