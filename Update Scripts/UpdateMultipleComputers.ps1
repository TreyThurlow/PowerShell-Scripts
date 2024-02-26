#-----------------------------------------------------------
#
# Author: Trey Thurlow
# 
# Purpose: Install updates for multiple computers
#
# 
#
#-----------------------------------------------------------

#Variable containing Computer List
$Computers = Get-Content Path\To\File

#Tests the connection to the computer. If successful connection, it writes teh name of the computer into the Alives text file. If dead, it writes to the Dead file.
Foreach ($Computer in $Computers) {
    if (Test-Connection -ComputerName $Computer -Quiet -Count 1) {
        Write-Output $Computer >> .\Alives.txt
    }
    else {
        Write-Output $Computer >> .\Deads.txt
    }
}

#Connects to the list of computers that are online and creates a variable that contains all open sessions.
$pso = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck
Get-Content .\Alives.txt | New-PSSession -SessionOption $pso
$sessions = Get-PSSession

#Runs the commands on all remote computers (hopefully). If this doesn't work, you can try to do an Invoke-Command per command.
Foreach ($session in $sessions){
#Location of Updates

New-PSDrive -Name Y -PSProvider FileSystem -Root "Path\To\Updates"

#Variables for commands

$msiexec = 'C:\Windows\System32\msiexec.exe'
$wusa = 'C:\Windows\System32\wusa.exe'

#Create a working directory.

$UpdatePath = 'Y:\'

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
    Start-Process -Wait $msiexec -ArgumentList "/p `"$MSPUpdateFilePath`" /qn /quiet /passive /norestart"
}

Write-Host "MSP Updates Complete" -BackgroundColor Black -ForegroundColor Yellow

#Installs all MSI Updates
Foreach ($MSIUpdate in $MSIUpdates) {
    $MSIUpdateFilePath = $MSIUpdate.FullName
    Write-Host "Installing MSI Update $($MSIUpdate.BaseName)" -BackgroundColor Black -ForegroundColor Green
    Start-Process $msiexec -ArgumentList "/i `"$MSIUpdateFilePath`" /qn /quiet /passive /norestart" -Wait
}

Write-Host "MSI Updates Complete" -BackgroundColor Black -ForegroundColor Yellow

#Installs all MSU Updates
Foreach ($MSUUpdate in $MSUUpdates) {
    $MSUUpdateFilePath = $MSUUpdate.FullName
    Write-Host "Installing MSU Update $($MSUUpdate.BaseName)" -BackgroundColor Black -ForegroundColor Green
    Start-Process $wusa -ArgumentList ($MSUUpdateFilePath, '/quiet', '/norestart') -Wait
}

Write-Host "MSU Updates Complete" -BackgroundColor Black -ForegroundColor Yellow

#Removes the PSDrive
Remove-PSDrive Y
}
