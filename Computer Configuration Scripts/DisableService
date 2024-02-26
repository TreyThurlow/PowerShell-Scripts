#------------------------------------------------------------------------------------------------------------
#
# Author: Trey Thurlow
#
# This script can be used to disable a specific service on multiple computers/servers
# 
# 
#
#------------------------------------------------------------------------------------------------------------

#Variable containing Computer List based on location and computer type.
$Location = Read-Host "Are you located at HomeBase or GSU?"

switch ($Location) {
    ("HomeBase") {
        $Type = Read-Host "Are you changing the DNS server on a Client, Member Server, or DC?"
        switch ($Type) {
            ("Client") {
                Write-Host "Setting Variables to HomeBase Clients..."
                $Computers = Get-Content "\\NetworkShare\Groups\Windows_Support\1. Knowledge Base\Powershell Scripts\ScriptInput\ClientList.txt"
            }
            ("Member Server") {
                Write-Host "Setting Variables to HomeBase Member Servers..."
                $Computers = Get-Content "\\NetworkShare\Groups\Windows_Support\1. Knowledge Base\Powershell Scripts\ScriptInput\MemberServerList.txt"
            }
            ("DC") {
            Write-Host "Setting Variables to HomeBase Domain Controllers..."
            $Computers = Get-Content "\\NetworkShare\Groups\Windows_Support\1. Knowledge Base\Powershell Scripts\ScriptInput\DCServerNames.txt"
            }
        }
    }
    ("GSU") {
        $Type = Read-Host "Are you changing the DNS server on a Client, Member Server, or DC?"
        switch ($Type) {
            ("Client") {
                Write-Host "Setting Variables to GSU Clients..."
                $Computers = Get-Content "\\Network\Share\Scripts\ScriptIndex\ClientList.txt"
            }
            ("Member Server") {
                Write-Host "Setting Variables to GSU Member Servers..."
                $Computers = Get-Content "\\Network\Share\Scripts\ScriptIndex\MemberServerList"
            }
            ("DC") {
            Write-Host "Setting Variables to GSU Domain Controllers..."
            $Computers = Get-Content "\\Network\Share\Scripts\ScriptIndex\DomainControllerList.txt"
            }
        }
    }
}
#This variable contents the name of the server that you are wanting to disable.
$ServiceName = Read-Host "Enter the Service Name that you want to disable."
#Command to disable the service
Foreach ($Computer in $Computers) {
    Invoke-Command -ComputerName $Computer -ScriptBlock {
        Get-Service -Name $ServiceName | Stop-Service -PassThru | Set-Service -StartupType Disabled
    }
}
