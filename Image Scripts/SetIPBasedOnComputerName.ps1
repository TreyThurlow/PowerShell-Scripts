############################################################################################################
#                                                                                                          #
#                                                                                                          #
#       This script was created by Trey Thurlow and George Michalski with the help of Microsoft Docs.      #
#                                                                                                          #
#       The purpose of this script is to import a CSV file with a list of computer names and their IPs.    #
#       It will then set the IP, DNS servers, Subnet Mask, and Gateway per computer selection.             #
#       The person running the script will be able to select what computer name they want.                 #
#       It can be used in a DHCP environment if the set IP address command is removed.                     #
#                                                                                                          #
#       I originally built it to be used in SCCM for imaging.                                              #
#                                                                                                          #
############################################################################################################

#Imports the CSV with Computer Names and IPs
$NameIPList = Import-CSV ".\ComputerNamesIPs.csv"

#Begin Creating the Form
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Creates the size of the form, sets the title of the form window, and where the form is located.
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Select a Computer'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow
$form.TopMost = $true

#Creates the 'OK' Button
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

#Creates the 'Cancel' Button
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

#Provides the label text that describes the information
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please select a computer:'
$form.Controls.Add($label)

#Creates the list box
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 80
$listBox.Font = New-Object System.Drawing.Font("Comic Sans",15,[System.Drawing.FontStyle]::Regular)

#Calls the imported CSV and adds the computer names to the list box.
$NameIPList | ForEach-Object { $listBox.Items.Add($_.ComputerName)}

#Instructs Windows to open the box on top of other windows
$form.Controls.Add($listBox)
$form.Topmost = $true

#The results
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $UserSelection =$listBox.SelectedItem
}

#Calls the imported CSV again and searches it for the $UserSelection Variable. It then will select the IP Address for the selected computer.
$IPAddress = $NameIPList | Where-Object {$_.ComputerName -eq $UserSelection} | Select-Object -Expand IPAddress

#Gets the Interface Index for all network adapters on a system.
$NetInt = Get-WmiObject win32_networkadapterconfiguration -Filter "ipenabled = 'true'"

#The next three commands sets the IP Address, Subnet Masj (PrefixLength), Default Gateway, and DNS Server
$NetInt.EnableStatic($IPAddress, "255.255.255.128")
$NetInt.SetGateways("1.1.1.1")
$NetInt.SetDNSServerSearchOrder("1.1.1.1")

#Creay=tes a text file with the computer name to be imported to the tast sequence later as OSDComputerName
New-Item -Path "X:\ComputerName.txt" -Value $UserSelection
