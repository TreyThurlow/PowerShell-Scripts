# Set the Variables
$ResultDest = Read-Host "Type the full path where you would like to save the results (C:\Users\USERNAME\Documents\). ONLY THE PATH. The script will handle the filename."
$Date = Get-Date -Format "yyyy-MM-dd"
$ResultFile = $ResultDest + "CurrentLoggedOnUsers" + "_" + $Date + ".csv"
$NoResponse = "---No Response---"

# The Script
$Results = foreach ($Computer in $Computers)
    {
    Write-Host "Connecting to $Computer ..." -BackgroundColor Black -ForegroundColor Green
    if (Test-Connection -ComputerName $Computer -Count 1 -Quiet)
        {
        Write-Host "    System $Computer reached successfully."
        $CurrentUser = (Get-WmiObject -Class win32_ComputerSystem -ComputerName $Computer).UserName
        $IPAddressList = (([System.Net.Dns]::Resolve($Computer)).AddressList.IPAddressToString) -join ', '
        $TempObject = [PSCustomObject]@{
            MachineName = $Computer
            Status = 'Online'
            CurrentUser = $CurrentUser
            IPAddressList = $IPAddressList
            TimeStamp = (Get-Date).ToString("s")
            }
        }
        else
        {
        Write-Host "Unable to reach $Computer." -BackgroundColor Red -ForegroundColor White
        $TempObject = [PSCustomObject]@{
            MachineName = $Computer
            Status = $NoResponse
            CurrentUser = $NoResponse
            IPAddressList = $NoResponse
            TimeStamp = (Get-Date).ToString("s")
            }
        }
    $TempObject
    } 

$Results |
    Export-Csv -LiteralPath $ResultFile -NoTypeInformation
