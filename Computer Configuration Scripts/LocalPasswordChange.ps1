#------------------------------------------------------------------------------------------------------------
#
# Author: Trey Thurlow
#
# This script can be used to change the password of the Local Administrator Account
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

#This command specifies the local account
$LocalAccount = Read-Host "Type the name of the local account that you are wanting to change the password for."

#This command is where you enter the password of the local account
$Password = Read-Host -AsSecureString

#Performs the command per alive computer.
Foreach ($Computer in $Computers) {
    Invoke-Command -ComputerName $Computer -ScriptBlock { 
        #Command to actually change the password
        Set-LocalUser $LocalAccount -Password $Password -UserMayChangePassword 1
    }
}

