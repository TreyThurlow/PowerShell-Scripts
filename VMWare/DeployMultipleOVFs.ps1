<#
.SYNOPSIS
    This script will extract OVF files from OVA files and then import them into an ESXi Server. This script was build without access to vCenter and may need to be modified slightly to fit an environment with vCenter. It will also ask if additional network adapters are needed to be added to the Virtual Machines.

    This script REQUIRES the VMware OVFTool installed to extract the OVA files.
.NOTES
Author: SSgt Trey Thurlow, NPES NCOIC, JCA

Creation Date: 11/2/2022
#>

<#
This first section of the script contains the variables that are "static" throughout the script, meaning they won't change. such as file location of ESXi Server
#>

$ServerName = Read-Host "Enter the ESXi Server name that you want to store the VMs on."
$FilePath = Read-Host "Enter the File Path that the OVA files are stored on."
$DiskFormat = Read-Host "Do you want Thick or Thin provisioned?"

<#
The below section will extract the OVA File into OVF, VMDK, and MF files. These files are needed by the next part of the script to import the Virtual Machines. Comment out the below foreach loop if you do not have any OVA files and only have OVF files.
#>

foreach ($OVA in (Get-ChildItem -Path "$FilePath\*.ova")) {
    & "C:\Program Files\VMware\VMware OVF Tool\ovftool.exe" $OVA "$FilePath\$OVA"
}

<#
Connects to the ESXi Server that was entered earlier
#>

Connect-VIServer $ServerName

<#
This next foreach loop is the actual process of importing the Virtual Machines. It requires user input to declare the name of each Virtual Machine and the datastore that the virutal machine will go to.
#>

$ESXiHost = Get-VMHost -Name $ServerName
foreach ($OVF in (Get-ChildItem -Path "$FilePath\*.ovf")) {
    $Datastore = Read-Host "What datastore does this VM need to go to?"
    $VMDatastore = Get-Datastore -Name $Datastore
    $VMName = Read-Host "What will the name of the VM be?"
    Write-Host "Importing $VMName to $Datastore on $ServerName." -ForegroundColor Green -BackgroundColor Black
    Import-VApp -Source $OVF -VMHost $ESXiHost -Datastore $VMDatastore -DiskstorageFormat $DiskFormat -RunAsync -Name $VMName -Force
}

