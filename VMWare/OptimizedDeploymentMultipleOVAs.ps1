# Define Credentials for vSphere Connection
$vcUser = "<vSphere_username>"
$vcPassword = "<vSphere_password>"
$vcServer = "<vSphere_server>"

# Connect to vSphere Server
Connect-VIServer -Server $vcServer -User $vcUser -Password $vcPassword

# Define Variables
$ovaDir = "C:\VMs\OvaFiles" # Path where the OVA files are located
$VMFolder = "Production" # Name of the folder in which VMs will be deployed.
$Datastore = "VMFS01" # Name of the datastore where VMs will be deployed.
$VMHost = "ESXi_Server_Name" # Name of the host where VMs will be deployed.

# Get list of OVA file names in the directory
$OVAFiles = Get-ChildItem $ovaDir | Where-Object {$_.Extension -eq '.ova'} | Select-Object -ExpandProperty Name

# Loop through the OVA files and deploy the VM
foreach ($OVA in $OVAFiles)
{
    $vmName = ($OVA -split '\.ova')[0]
    $ovaPath = Join-Path $ovaDir $OVA
    $ovf = (get-ovfconfig $ovaPath).First()

    # Create ESXi Host VM Configuration Spec
    $vmConfigSpec = New-VM -Name $vmName -VMFilePath $ovaPath -MemoryGB $ovf.MemorySizeMB/1024 -NumCpu $ovf.NumCPUs -DiskGB $ovf.StorageSizeGB -Datastore $Datastore -Location $VMFolder -VMHost $VMHost

    # Deploy the Virtual Machine by Importing from OVA File
    $DeployTask = $vmConfigSpec | Import-VApp -VMHost $VMHost -Datastore $Datastore -DiskStorageFormat $ovf.DiskFormat.ToUpper() -Force

    # Wait until VM deployment is complete
    While ($DeployTask.State -ne 'Success') {
        Start-Sleep -s 10
        $DeployTask | ForEach-Object{ $DeployTask.Refresh() }
    }

    Write-Host "VM $vmName has been deployed successfully."
}

# Disconnect from vSphere Server
Disconnect-VIServer -Confirm:$false
