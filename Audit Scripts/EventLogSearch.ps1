#------------------------------------------------------------------------------------------------------------
#
# Author: Trey Thurlow
#
# This script can be used to check for specific event logs for all servers or only few servers.
# 
#------------------------------------------------------------------------------------------------------------

#This command will allow you to select your smart card for suthentication. Be sure to select the right card for the server/computer type. 7 account for workstations, 8 for members servers, and 9 for domain controllers.
$cred = Get-Credential

#This variable will allow you to type the names of the servers and it will store your input into the variable to be used later.
$Servers = Read-Host "Type the names of the servers you want to check for Event Logs with commas separating the names, no spaces. (server1,server2,server3)"

#If you would rather use a file location, uncomment the following line (Line 16) and comment out the above line (line 13). and type the path of the file after the "Get-Content" command.
#$Servers = Get-Content PATH/TO/File.txt

#This variable will allow you to enter the type of event log that you are wanting to search for and store it into the variable.
$EventLog = Read-Host "Enter the type of Event Log you are searching for (Security, Application, etc)."

#This variable will allow you to type the Event ID that you are wanting to search for and store it into the variable.
$EventID = Read-Host "Type the Event ID that you are searching for."

#This variable allows you to specify where you want to store the file.
$ResultDest = Read-Host "Type the full path where you would like to save the results (C:\Users\USERNAME\Documents\). ONLY THE PATH. The script will handle the filename."

#This variable gets the current date.
$Date = Get-Date -Format "yyyy-MM-dd"

#This variable creates the file name with the destination to save the file.
$ResultFile = $ResultDest + "EventLogSearch" + "_" + $Date + ".csv"

#This variable holds all of the additional options for PSSessions
$PSO = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck

#This command will begin a PowerShell Session with all of the computers that were in the $Servers variable
New-PSSession -ComputerName $Servers -SessionOption $PSO Get-Credential $cred

#This variable will allow you to run commands against all of the computers that you opened sessions with.
$Sessions = Get-PSSession

#This is the command to search for the event log. It takes all of the information that your typed in and will search for the event log.
$Results = Invoke-Command -Session $Sessions -ScriptBlock
    {
        Get-EventLog $EventLog | Where-Object {$_.EventID -eq $EventID} | Select-Object MachineName,InstanceId,Source,Time | Format-Table -AutoSize
    }

#This part of the command puts the results into a CSV file and saves it to the location specified previously.
$Results |
    Export-CSV -LiteralPath $ResultFile

#This command removes the sessions that you opened.
Remove-PSSession $Sessions
