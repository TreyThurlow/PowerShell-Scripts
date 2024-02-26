#------------------------------------------------------------------------------------------------------------
#
# Author: Trey Thurlow
#
# This script can be used to change the Primary and Secondary DNS Servers on all Clients.
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
                Write-Host "Setting Variables to RRMC Clients..."
                $Computers = Get-Content "\\NetworkShare\Groups\Windows_Support\1. Knowledge Base\Powershell Scripts\ScriptInput\ClientList.txt"
            }
            ("Member Server") {
                Write-Host "Setting Variables to RRMC Member Servers..."
                $Computers = Get-Content "\\NetworkShare\Groups\Windows_Support\1. Knowledge Base\Powershell Scripts\ScriptInput\MemberServerList.txt"
            }
            ("DC") {
            Write-Host "Setting Variables to RRMC Domain Controllers..."
            $Computers = Get-Content "\\NetworkShare\Groups\Windows_Support\1. Knowledge Base\Powershell Scripts\ScriptInput\DCServerNames.txt"
            }
        }
    }
    ("GSU") {
        $Type = Read-Host "Are you changing the DNS server on a Client, Member Server, or DC?"
        switch ($Type) {
            ("Client") {
                Write-Host "Setting Variables to PNT Clients..."
                $Computers = Get-Content "\\Network\Share\Scripts\ScriptIndex\ClientList.txt"
            }
            ("Member Server") {
                Write-Host "Setting Variables to PNT Member Servers..."
                $Computers = Get-Content "\\Network\Share\Scripts\ScriptIndex\MemberServerList"
            }
            ("DC") {
            Write-Host "Setting Variables to PNT Domain Controllers..."
            $Computers = Get-Content "\\Network\Share\Scripts\ScriptIndex\DomainControllerList.txt"
            }
        }
    }
}

#This variable stores the IP Addresses that you enter for the DNS servers.
$NewDNSServerSearchOrder = Read-Host "Type the IP Addresses of the two new DNS Servers with a comma and space separating them (1.1.1.1, 2.2.2.2)"

#Begins the commands per computer
Foreach ($Computer in $Computers) {
    Write-Host "$($Computer): " -ForegroundColor Yellow
    Invoke-Command -ComputerName $Computer -ScriptBlock {
       
        $Adapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.DHCPEnabled -ne 'True' -and $_.DNSServerSearchOrder -ne $null}

        #Show DNS Servers before Update
        Write-Host "Before: " -ForegroundColor Green
        $Adapters | Foreach-Object {$_.DNSServerSearchOrder}

        #Update DNS Servers
        $Adapters | Set-DnsClientServerAddress -ServerAddresses $NewDNSServerSearchOrder

        #Show DNS Servers after Update
        $Adapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.DHCPEnabled -ne 'True' -and $_.DNSServerSearchOrder -ne $null}
        Write-Host "After: " -ForegroundColor Cyan
        $Adapters | Foreach-Object {$_.DNSServerSearchOrder}
    }
}
