#------------------------------------------------------------------------------------------------------------
#
# Author: Trey Thurlow
#
# This script can be used to change the password of an Active Directory User Account.
# The script also sets the password as a default password to allow the user to set their own password
# 
# 
#
#------------------------------------------------------------------------------------------------------------

#This command will allow you to run this script on your normal account, as long as you select your domain admin account.
$cred = Get-Credential

#Sets a variable for the username
$Identity = Read-Host "Enter the Username"

#Sets the default password into a variable
$Password = "12qwaszx!@QWASZX"

#Resets the User's account to the default Password
Set-ADAccountPassword -Identity $Identity -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$Password" -Force) -PassThru -Confirm:$false -Credential $cred

#Unlocks the User's account
Unlock-ADAccount -Identity $Identity -Credential $cred

#Allows the User to change their password at login
Set-ADUser -ChangePasswordAtLogon $true -Identity $Identity -Confirm:$false -verbose -Credential $cred

Write-Host "Password reset successful and set to change at next logon." -ForegroundColor Green
