#Connect to Active Directory using the command
Import-Module ActiveDirectory

#Variable containing Computer List obtained from Active Directory
$Computers = Get-ADComputer -Filter {OperatingSystem -Like "Windows*"} -Properties Name | Select-Object -ExpandProperty Name

#Arrays to store online and offline computers
$OnlineComputers = @()
$OfflineComputers = @()

#Tests the connection to the computer. Populates the online and offline arrays
Foreach ($Computer in $Computers) {
    if (Test-Connection -ComputerName $Computer -Quiet -Count 1) {
        $OnlineComputers += $Computer
    }
    else {
        $OfflineComputers += $Computer
    }
}

#Iteration over online computers in batches of 10
$BatchSize = 10
$Batches = [Math]::Ceiling($OnlineComputers.Count / $BatchSize)
for ($i = 0; $i -lt $Batches; $i++) {
    $StartIndex = $i * $BatchSize
    $EndIndex = [Math]::Min(($StartIndex + $BatchSize - 1), ($OnlineComputers.Count - 1))

    #Connects to the list of online computers, creates a variable that contains all open sessions.
    $pso = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck
    $OnlineComputers[$StartIndex..$EndIndex] | New-PSSession -SessionOption $pso
    $sessions = Get-PSSession

    #Runs the commands on all remote computers in the current batch.
    Foreach ($session in $sessions){
        #Location of Updates
        $UpdatePath = 'Path\To\Updates'

        #Variables for commands
        $msiexec = 'C:\Windows\System32\msiexec.exe'
        $wusa = 'C:\Windows\System32\wusa.exe'

        #Variable that contains all MSU Updates in the directory
        $MSUUpdates = Get-ChildItem -Path $UpdatePath -Recurse | Where-Object {$_.Name -like "*msu*"}

        #Variable that contains all MSP Updates in the directory
        $MSPUpdates = Get-ChildItem -Path $UpdatePath -Recurse | Where-Object {$_.Name -like "*msp*"}

        #Variable that contains all MSI Updates in the directory
        $MSIUpdates = Get-ChildItem -Path $UpdatePath -Recurse | Where-Object {$_.Name -like "*msi*"}

        #Installs all MSP Updates
        Foreach ($MSPUpdate in $MSPUpdates) {
            $MSPUpdateFilePath = $MSPUpdate.FullName
            Write-Host "Installing MSP Update $($MSPUpdate.BaseName)" -BackgroundColor Black -ForegroundColor Green
            Invoke-Command -Session $session -ScriptBlock {
                Start-Process $using:msiexec -ArgumentList "/p `"$using:MSPUpdateFilePath`" /qn /quiet /passive /norestart" -Wait
            }
        }

        Write-Host "MSP Updates Complete" -BackgroundColor Black -ForegroundColor Yellow

        #Installs all MSI Updates
        Foreach ($MSIUpdate in $MSIUpdates) {
            $MSIUpdateFilePath = $MSIUpdate.FullName
            Write-Host "Installing MSI Update $($MSIUpdate.BaseName)" -BackgroundColor Black -ForegroundColor Green
            Invoke-Command -Session $session -ScriptBlock {
                Start-Process $using:msiexec -ArgumentList "/i `"$using:MSIUpdateFilePath`" /qn /quiet /passive /norestart"
            }
        }

        Write-Host "MSI Updates Complete" -BackgroundColor Black -ForegroundColor Yellow

        #Installs all MSU Updates
        Foreach ($MSUUpdate in $MSUUpdates) {
            $MSUUpdateFilePath = $MSUUpdate.FullName
            Write-Host "Installing MSU Update $($MSUUpdate.BaseName)" -BackgroundColor Black -ForegroundColor Green
            Invoke-Command -Session $session -ScriptBlock {
                Start-Process $using:wusa -ArgumentList ($using:MSUUpdateFilePath, '/quiet', '/norestart')
            }
        }

        Write-Host "MSU Updates Complete" -BackgroundColor Black -ForegroundColor Yellow

        #Removes the PSDrive
        Invoke-Command -Session $session -ScriptBlock {
            Remove-PSDrive Y
        }
    }

    #Cleans up the sessions
    Remove-PSSession $sessions
}

#Writes results to a file
$OnlineComputers | Set-Content .\Alives.txt
$OfflineComputers | Set-Content .\Deads.txt
