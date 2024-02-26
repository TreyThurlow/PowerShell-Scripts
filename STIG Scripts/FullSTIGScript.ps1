<# This Section checks for the most up to date java file and removes all of the older files. It then adds config / property files if they do not already exist, and adds the required text inside the files if they do not exist.
All of the STIG #'s can be located above the command. HKLM / HKCU registry values are located below with how the script works for them as well. Check line 100 and line 660 

#First Line finds the most up to date version of java and deletes the rest. 




clear
#Placing the DOD_EP_FILE 
echo "To run the script:"
echo "Go to your windows 10 STIG folder you downloaded from cyber.mil"
echo "Extract the file onto your desktop"
echo "Go into the extracted file -> Supporting Files"
echo "Move the file labelled DOD_EP_V2 onto your desktop"
echo "Once the file is onto your desktop, CTRL+C out of the script"
echo "In the terminal, type the command 'cd' followed by the filepath to the DOD_EP_V2 file"
echo "An example would be 'cd C:\Users\(DOD_ID#)\Desktop'"
echo "Powershell should say something like PS C:\Users\DODIDa.adw\Desktop if done correctly"
echo "Once you are in the directory where your DOD_EP file is located, re-run the script"
echo ""
echo ""
echo "READ ABOVE BEFORE CONTINUING!!!! SCRIPT WILL NOT WORK WITHOUT FOLLOWING ABOVE INSTRUCTIONS"
echo "READ ABOVE BEFORE CONTINUING!!!! SCRIPT WILL NOT WORK WITHOUT FOLLOWING ABOVE INSTRUCTIONS"
#Var for Computer Name to remote into host. 
#>

#Takes input from a file, pings computers to see if they are on, and then puts the alive computers into a variable.


$targets = Get-Content .\Targets.txt
$alives = foreach ($targ in $targets) {
    if (Test-Connection -ComputerName $targ -Quiet -Count 2) {
        Write-Output $targ >> theseAREALIVE.txt
    }
}


Copy-Item ".\DOD_EP_V2.xml" -Destination "\\$alives\C$\Temp\EPFile" 



#$CompName = Read-Host -Prompt "Please enter the computer name. Example: CZQZW-461M9L"
$NotFrankensteins = Get-Content .\theseAREALIVE.txt
foreach ($NotFrankenstein in $NotFrankensteins) {
Getmac /S $NotFrankenstein >> .\MAC.txt
Invoke-Command -ComputerName $NotFrankenstein -ScriptBlock {



Set-ProcessMitigation -PolicyFilePath C:\Temp\EPFile


$donotdelete = (Get-ChildItem -Path "C:\Program Files\Java" -Filter "*jre*" | Sort-Object -Property LastWriteTime -Descending | Select -ExpandProperty Name)[0]
Get-ChildItem -Path "C:\Program Files\Java" -Filter "*jre*" | foreach-object {
    if ($_.Name.ToString() -ne $donotdelete -and $_.Name.toString() -ne "jre1.8.0_241" ){
        Remove-Item -LiteralPath $_.PSPath -Recurse;
    }
}



#V-77095
#Set-ProcessMitigation -System -Enable BottomUp
#V-77091
#Set-ProcessMitigation -System -Enable DEP
#V-77097
#Set-ProcessMitigation -System -Enable CFG
#V-77101
#Set-ProcessMitigation -System -Enable SEHOP


#V-63451
AuditPol /get /category:* | Select-String "Plug and Play Events                    Success"
AuditPol /set /subcategory:"Plug and Play Events"

#V-63457
AuditPol /get /category:* | Select-String "Group Membership                        Success"
AuditPol /set /subcategory:"Group Membership"

#V-66943
New-Item -Path "C:\Program Files\Java\jre1.8.0_241\lib" -Name "deployment.properties"

#V-66939
New-Item -Path "C:\Program Files\Java\jre1.8.0_241\lib" -Name "deployment.config"

#V-66959
New-Item -Path "C:\Program Files\Java\jre1.8.0_241\lib" -Name "exception.sites"


New-Item -Path "C:\Program Files\Java\jre1.8.0_241\lib" -Name "scriptfile1221"

$var2 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\scriptfile1221" | Select-string "d"

Remove-Item -Path "C:\Program Files\Java\jre1.8.0_241\lib\scriptfile1221" -Recurse




#V-66953
$var1 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.security.validation.ocsp.locked"
If ($var1 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.security.validation.ocsp.locked"}

$var22 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.security.validation.ocsp=true"
If ($var22 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.security.validation.ocsp=true"}


#V-66723
$var3 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.security.revocation.check.locked"
If ($var3 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.security.revocation.check.locked"}

$var4 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.security.revocation.check=ALL_CERTIFICATES"
If ($var4 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.security.revocation.check=ALL_CERTIFICATES"}

#V-66963
$var5 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.insecure.jres=PROMPT"
If ($var5 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.insecure.jres=PROMPT"}

$var6 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.insecure.jres.locked"
If ($var6 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.insecure.jres.locked"}

#V-66959
$var7 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.security.validation.crl.locked"
If ($var7 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.security.validation.crl.locked"}

$var8 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.security.validation.crl=true"
If ($var8 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.security.validation.crl=true"}

#V-66957
$var9 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.user.security.exception.sites=C:\Program Files\Java\jre1.8.0_241\lib\exception.sites"
If ($var9 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.user.security.exception.sites=C:\Program Files\Java\jre1.8.0_241\lib\exception.sites"}

#V-66955
$var10 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.security.blacklist.check=true"
If ($var10 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.security.blacklist.check=true"}

$var10 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.security.blacklist.check.locked"
If ($var10 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.security.blacklist.check.locked"}

#V-66951
$var11 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.security.askgrantdialog.show=false"
If ($var11 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.security.askgrantdialog.show=false"}

$var12 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.security.askgrantdialog.show.locked"
If ($var12 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.security.askgrantdialog.show.locked"}

#V-66949
$var13 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.security.askgrantdialog.notinca=false"
If ($var13 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.security.askgrantdialog.notinca=false"}

$var14 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" | Select-string "deployment.security.askgrantdialog.notinca.locked"
If ($var14 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties" "deployment.security.askgrantdialog.notinca.locked"}

#V-66941
$var15 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.config" | Select-string "deployment.system.config.mandatory=true"
If ($var15 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.config" "deployment.system.config.mandatory=true"}

$var16 = Get-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.config" | Select-string "deployment.system.config=file:///C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties"
If ($var16 -eq $var2)
{Add-Content "C:\Program Files\Java\jre1.8.0_241\lib\deployment.config" "deployment.system.config=file:///C:\Program Files\Java\jre1.8.0_241\lib\deployment.properties"}





<#ALL HKCU VALUES IAW STIGS

Script works by removing all HKCU values and replacing them with the values determined by the STIGs. All Vuln-ID #'s are annotated under the section where the key/value is added.
To use: Enter-PSSession
Type workstation name
Run the script
Errors for properties or keys already existing or not existing are normal depending on what the STIG asked to be done. It will try to remove items / properties / keys that are not there on some systems because it is required. 
Also, an error may pop up for a path not existing. This is okay, as the path keycupoliciesmsvbasecurity needed to be removed, and does not exist on most systems. Same scenario for FileExtensionsRemoveLevel2 / Level1
All of the HKLM values can be found below the HKCU values. 
#>
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\excel"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\word"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\word\options"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\word\security"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\word\security\fileblock"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\word\security\filevalidation"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\word\security\protectedview"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\word\security\trusted locations"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\excel\security"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\excel\security\trusted locations"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\excel\security\protectedview"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\excel\options"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\excel\options\binaryoptions"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\excel\security\filevalidation"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\excel\security\fileblock"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\outlook"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\rpc"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\outlook\options"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\outlook\options\rss"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\outlook\options\webcal"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\outlook\options\mail"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\outlook\options\pubcal"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\outlook\security"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\access"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\access\settings"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\access\security"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\access\internet"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\publisher"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\publisher\security"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\Internet Explorer"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\Internet Explorer\Main"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\PowerPoint"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\PowerPoint\security"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\PowerPoint\security\fileblock"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\PowerPoint\security\filevalidation"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\PowerPoint\security\protectedview"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\PowerPoint\options"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\common"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\common\security"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\common\Smart Tag"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\feedback"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\broadcast"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\security"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\fixedformat"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\drm"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\research"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\research\translation"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\security"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\trustcenter"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\ptwatson"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\security\trusted locations"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Internet Explorer"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Internet Explorer\Main"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\publisher"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\publisher\security"
New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\common\research\translation"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\trusted locations"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\osm"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\wef"
New-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\wef\trustedcatalogs"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\meetings"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\meetings\profile"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\options"
New-Item -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\options\rss"
New-Item -Path "HKCU:\Software\Adobe"
New-Item -Path "HKCU:\Software\Adobe\Adobe Acrobat"
New-Item -Path "HKCU:\Software\Adobe\Adobe Acrobat\2015"
New-Item -Path "HKCU:\Software\Adobe\Adobe Acrobat\2015\AVGeneral"








Remove-ItemProperty -Path "HKCU:\Software\Policies" -Name "DisablePersonalSync" 
Remove-ItemProperty -Path "HKCU:\Software\Adobe\Adobe Acrobat\2015\AVGeneral" -Name "bFIPSMode" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\common\security" -Name "AutomationSecurityPublisher" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\publisher" -Name "PromptForBadFiles" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\protectedview" -Name "DisableIntranetCheck" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\protectedview" -Name "DisableIntranetCheck" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\protectedview" -Name "DisableIntranetCheck" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\filevalidation" -Name "DisableEditFromPV" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\protectedview" -Name "DisableUnsafeLocationsInPV" 
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\OneDrive" -Name "DisablePersonalSync"  
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "SupressNameChecks" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "NoCheckOnSessionSecurity" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "MinEncKey" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "ForceDefaultProfile" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\options\rss" -Name "EnableAttachments" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\meetings\profile" -Name "ServerUI" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\webcal" -Name "Disable" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\webcal" -Name "EnableAttachments" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\rss" -Name "EnableFullTextHTML" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "AuthenticationService" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\rpc" -Name "EnableRPCEncryption" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "JunkMailEnableLinks" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "Level" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "Intranet"  
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "Internet"  
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "TrustedZone" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "UnblockSafeZone" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "UnblockSpecificSenders" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "BlockExtContent" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "UseCRLChasing" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "RespondToReceiptRequests" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "ClearSign" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "FIPSMode" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "MsgFormats" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "ExternalSMime" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "trustedaddins" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PromptOOMFormulaAccess" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PromptOOMSaveAs" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PromptOOMMeetingTaskRequestResponse" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PromptOOMAddressInformationAccess" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PromptOOMAddressBookAccess" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PromptOOMSend" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PromptOOMCustomAction" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "EnableOneOffFormScripts" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "ShowLevel1Attach" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "AdminSecurityMode" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook" -Name "DisallowAttachmentCustomization" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "EnableRememberPwd" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "AddinTrust" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "AllowActiveXOneOffForms" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PublicFolderScript"
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "SharedFolderScript"
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\pubcal" -Name "RestrictedAccessOnly" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\pubcal" -Name "PublishCalendarDetailsPolicy" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\pubcal" -Name "DisableDav" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\pubcal" -Name "DisableOfficeOnline" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\security" -Name "RequireAddinSig" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\internet" -Name "DoNotUnderlineHyperlinks"
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\security" -Name "NoTBPromptUnsignedAddin" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\security" -Name "ModalTrustDecisionOnly"
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\settings" -Name "RequireAddinSig" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\settings" -Name "Default File Format" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\security" -Name "vbawarnings" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\ptwatson" -Name "PTWOptIn" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\trustcenter" -Name "TrustBar" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\security" -Name "DRMEncryptProperty" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\security" -Name "OpenXMLEncryptProperty" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\security" -Name "OpenXMLEncryption" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\security" -Name "DefaultEncryption12" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\common\security" -Name "AutomationSecurity" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\security\trusted locations" -Name "Allow User Locations" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\common\Smart Tag" -Name "NeverLoadManifests" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\drm" -Name "RequireConnection" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\fixedformat" -Name "DisableFixedFormatDocProperties" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\security" -Name "EncryptDocProps" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\broadcast" -Name "disabledefaultservice" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\broadcast" -Name "disableprogrammaticaccess" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\feedback" -Name "includescreenshot" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\wef\trustedcatalogs" -Name "requireserververification" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\osm" -Name "enablefileobfuscation" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common" -Name "sendcustomerdata" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\fileblock" -Name "OpenInProtectedView" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\filevalidation" -Name "EnableOnLoad" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\protectedview" -Name "DisableInternetFilesInPV" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security" -Name "RequireAddinSig" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security" -Name "notbpromptunsignedaddin" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\trusted locations" -Name "AllLocationsDisabled" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\trusted locations" -Name "AllowNetworkLocations" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\options" -Name "DefaultFormat" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security" -Name "AccessVBOM" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\protectedview" -Name "DisableAttachmentsInPV" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security" -Name "VBAWarnings" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security" -Name "blockcontentexecutionfrominternet" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\fileblock" -Name "OpenInProtectedView" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\filevalidation" -Name "EnableOnLoad" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\protectedview" -Name "DisableInternetFilesInPV" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security" -Name "RequireAddinSig" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security" -Name "NoTBPromptUnsignedAddin" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\trusted locations" -Name "AllLocationsDisabled" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\trusted locations" -Name "AllowNetworkLocations" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\options" -Name "DefaultFormat" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security" -Name "WordBypassEncryptedMacroScan" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security" -Name "AccessVBOM" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\filevalidation" -Name "openinprotectedview" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\filevalidation" -Name "DisableEditFromPV" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\protectedview" -Name "DisableAttachmentsInPV" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\options" -Name "DontUpdateLinks" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security" -Name "VBAWarnings" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\research\translation" -Name "useonline" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\fileblock" -Name "Word2Files" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\fileblock" -Name "Word2000Files" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\fileblock" -Name "Word60Files" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\fileblock" -Name "Word95Files" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\fileblock" -Name "Word97Files" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\fileblock" -Name "WordXPFiles" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security" -Name "blockcontentexecutionfrominternet" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL4Macros" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL4Workbooks" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL4Worksheets" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL95Workbooks" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL9597WorksbooksandTemplates" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "OpenInProtectedView" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "DifandSylkFiles" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL2Macros" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL2Worksheets" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL3Macros" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL3Worksheets" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\filevalidation" -Name "EnableOnLoad" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "HtmlandXmlssFiles" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "DBaseFiles" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security" -Name "RequireAddinSig" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security" -Name "NoTBPromptUnsignedAddin" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\trusted locations" -Name "AllLocationsDisabled" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\trusted locations" -Name "AllowNetworkLocations" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\options" -Name "DefaultFormat" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\options\binaryoptions" -Name "fGlobalSheet_37_1" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security" -Name "AccessVBOM" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\protectedview" -Name "DisableAttachmentsInPV" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security" -Name "vbawarnings" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\options" -Name "extractdatadisableui" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security" -Name "blockcontentexecutionfrominternet" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Internet Explorer\Main" -Name "UseFormSuggest" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Internet Explorer\Main" -Name "FormSuggestPasswords" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\publisher\security" -Name "RequireAddinSig"
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\publisher\security" -Name "NoTBPromptUnsignedAddin" 
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\publisher\security" -Name "VBAWarnings" 

#V-82137
New-ItemProperty -Path "HKCU:\Software\Policies" -Name "DisablePersonalSync" -Value ”1” -PropertyType "Dword"
#V-80127
New-ItemProperty -Path "HKCU:\Software\Adobe\Adobe Acrobat\2015\AVGeneral" -Name "bFIPSMode" -Value ”1” -PropertyType "Dword"
#V-71675
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\common\security" -Name "AutomationSecurityPublisher" -Value ”3” -PropertyType "Dword"
#V-71673
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\publisher" -Name "PromptForBadFiles" -Value ”0” -PropertyType "Dword"
#V-71643
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\protectedview" -Name "DisableIntranetCheck" -Value ”0” -PropertyType "Dword"
#V-71641
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\protectedview" -Name "DisableIntranetCheck" -Value ”0” -PropertyType "Dword"
#V-71639
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\protectedview" -Name "DisableIntranetCheck" -Value ”0” -PropertyType "Dword"
#V-71407
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\filevalidation" -Name "DisableEditFromPV" -Value ”1” -PropertyType "Dword"
#V-71405
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\protectedview" -Name "DisableUnsafeLocationsInPV" -Value ”0” -PropertyType "Dword"
#V-71331
New-ItemProperty -Path "HKCU:\Software\Microsoft\OneDrive" -Name "DisablePersonalSync" -Value ”1” -PropertyType "Dword"
#V-71277
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "SupressNameChecks" -Value ”1” -PropertyType "Dword"
#V-71275
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "NoCheckOnSessionSecurity" -Value ”1” -PropertyType "Dword"
#V-71273
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "MinEncKey" -Value ”168” -PropertyType "Dword"
#V-71271
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "ForceDefaultProfile" -Value ”0” -PropertyType "Dword"
#V-71267
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\options\rss" -Name "EnableAttachments" -Value ”0” -PropertyType "Dword"
#V-71265
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\meetings\profile" -Name "ServerUI" -Value ”2” -PropertyType "Dword"
#V-71263
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\webcal" -Name "Disable" -Value ”1” -PropertyType "Dword"
#V-71261
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\webcal" -Name "EnableAttachments" -Value ”0” -PropertyType "Dword"
#V-71259
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\rss" -Name "EnableFullTextHTML" -Value ”0” -PropertyType "Dword"
#V-71255
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "AuthenticationService" -Value ”10” -PropertyType "Dword"
#V-71253
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\rpc" -Name "EnableRPCEncryption" -Value ”1” -PropertyType "Dword"
#V-71251
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "JunkMailEnableLinks" -Value ”0” -PropertyType "Dword"
#V-71249
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "Level" -Value ”3” -PropertyType "Dword"
#V-71247
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "Intranet" -Value ”0” -PropertyType "Dword"
#V-71245
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "Internet" -Value ”0” -PropertyType "Dword"
#V-71243
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "TrustedZone" -Value ”0” -PropertyType "Dword"
#V-71241
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "UnblockSafeZone" -Value ”1” -PropertyType "Dword"
#V-71239
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "UnblockSpecificSenders" -Value ”0” -PropertyType "Dword"
#V-71237
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\mail" -Name "BlockExtContent" -Value ”1” -PropertyType "Dword"
#V-71235
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "UseCRLChasing" -Value ”1” -PropertyType "Dword"
#V-71233
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "RespondToReceiptRequests" -Value ”2” -PropertyType "Dword"
#V-71231
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "ClearSign" -Value ”1” -PropertyType "Dword"
#V-71229
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "FIPSMode" -Value ”1” -PropertyType "Dword"
#V-71227
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "MsgFormats" -Value ”1” -PropertyType "Dword"
#V-71195
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "ExternalSMime" -Value ”0” -PropertyType "Dword"
#V-71193
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "trustedaddins" 
#V-71179
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PromptOOMFormulaAccess" -Value ”0” -PropertyType "Dword"
#V-71177
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PromptOOMSaveAs" -Value ”0” -PropertyType "Dword"
#V-71175
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PromptOOMMeetingTaskRequestResponse" -Value ”0” -PropertyType "Dword"
#V-71173
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PromptOOMAddressInformationAccess" -Value ”0” -PropertyType "Dword"
#V-71171
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PromptOOMAddressBookAccess" -Value ”0” -PropertyType "Dword"
#V-71169
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PromptOOMSend" -Value ”0” -PropertyType "Dword"
#V-71167
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PromptOOMCustomAction" -Value ”0” -PropertyType "Dword"
#V-71165
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "EnableOneOffFormScripts" -Value ”0” -PropertyType "Dword"
#V-71163
Remove-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security\FileExtensionsRemoveLevel1" 
#V-71161
Remove-Item -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security\FileExtensionsRemoveLevel2" 
#V-71159
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "ShowLevel1Attach" -Value ”0” -PropertyType "Dword"
#V-71157
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "AdminSecurityMode" -Value ”3” -PropertyType "Dword"
#V-71155
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook" -Name "DisallowAttachmentCustomization" -Value ”1” -PropertyType "Dword"
#V-71153
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "EnableRememberPwd" -Value ”0” -PropertyType "Dword"
#V-71151
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "AddinTrust" -Value ”1” -PropertyType "Dword"
#V-71149
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "AllowActiveXOneOffForms" -Value ”0” -PropertyType "Dword"
#V-71147
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "PublicFolderScript" -Value ”0” -PropertyType "Dword"
#V-71145
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\security" -Name "SharedFolderScript" -Value ”0” -PropertyType "Dword"
#V-71135
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\pubcal" -Name "RestrictedAccessOnly" -Value ”1” -PropertyType "Dword"
#V-71133
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\pubcal" -Name "PublishCalendarDetailsPolicy" -Value ”16384” -PropertyType "Dword"
#V-71131
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\pubcal" -Name "DisableDav" -Value ”1” -PropertyType "Dword"
#V-71129
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\outlook\options\pubcal" -Name "DisableOfficeOnline" -Value ”1” -PropertyType "Dword"

#V-70935
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\security" -Name "RequireAddinSig" -Value ”1” -PropertyType "Dword"
#V-70939
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\internet" -Name "DoNotUnderlineHyperlinks" -Value ”0” -PropertyType "Dword"
#V-70941
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\security" -Name "NoTBPromptUnsignedAddin" -Value ”1” -PropertyType "Dword"
#V-70945
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\security" -Name "ModalTrustDecisionOnly" -Value ”0” -PropertyType "Dword"
#V-70947
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\settings" -Name "RequireAddinSig" -Value ”1” -PropertyType "Dword"
#V-70947
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\settings" -Name "Default File Format" -Value ”12” -PropertyType "Dword"
#V-70953
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\security" -Name "vbawarnings" -Value ”2” -PropertyType "Dword"
#V-70855
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\ptwatson" -Name "PTWOptIn" -Value ”0” -PropertyType "Dword"
#V-70859
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\trustcenter" -Name "TrustBar" -Value ”1” -PropertyType "Dword"
#V-70861
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\security" -Name "DRMEncryptProperty" -Value ”1” -PropertyType "Dword"
#V-70863
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\access\security" -Name "OpenXMLEncryptProperty" -Value ”1” -PropertyType "Dword"
#V-70865
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\security" -Name "OpenXMLEncryption" -Value ”Microsoft Enhanced RSA and AES Cryptographic Provider,AES 256,256” -PropertyType "String"
#V-70867
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\security" -Name "DefaultEncryption12" -Value ”Microsoft Enhanced RSA and AES Cryptographic Provider,AES 256,256” -PropertyType "String"
#V-70869
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\common\security" -Name "UFIControls"
#V-70871
Remove-ItemProperty -Path "HKCU:\keycupoliciesmsvbasecurity" -Name "LoadControlsInForms"
#V-70873
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\common\security" -Name "AutomationSecurity" -Value ”2” -PropertyType "Dword"
#V-70875
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\security\trusted locations" -Name "Allow User Locations" -Value ”0” -PropertyType "Dword"
#V-70877
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\common\Smart Tag" -Name "NeverLoadManifests" -Value ”1” -PropertyType "Dword"
#V-70881
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\drm" -Name "RequireConnection" -Value ”1” -PropertyType "Dword"
#V-70883
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\fixedformat" -Name "DisableFixedFormatDocProperties" -Value ”1” -PropertyType "Dword"
#V-70885
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\security" -Name "EncryptDocProps" -Value ”1” -PropertyType "Dword"
#V-70889
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\broadcast" -Name "disabledefaultservice" -Value ”1” -PropertyType "Dword"
#V-70891
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\broadcast" -Name "disableprogrammaticaccess" -Value ”1” -PropertyType "Dword"
#V-70893
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\feedback" -Name "includescreenshot" -Value ”0” -PropertyType "Dword"
#V-70895
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\wef\trustedcatalogs" -Name "requireserververification" -Value ”1” -PropertyType "Dword"
#V-70897
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\osm" -Name "enablefileobfuscation" -Value ”1” -PropertyType "Dword"
#V-70899
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common" -Name "sendcustomerdata" -Value ”0” -PropertyType "Dword"
#V-70643
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\fileblock" -Name "OpenInProtectedView" -Value ”0” -PropertyType "Dword"
#V-70649
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\filevalidation" -Name "EnableOnLoad" -Value ”1” -PropertyType "Dword"
#V-70651
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\protectedview" -Name "DisableInternetFilesInPV" -Value ”0” -PropertyType "Dword"
#V-70655
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security" -Name "RequireAddinSig" -Value ”1” -PropertyType "Dword"
#V-70659
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security" -Name "notbpromptunsignedaddin" -Value ”1” -PropertyType "Dword"
#V-70663
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\trusted locations" -Name "AllLocationsDisabled" -Value ”1” -PropertyType "Dword"
#V-70665
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\trusted locations" -Name "AllowNetworkLocations" -Value ”0” -PropertyType "Dword"
#V-70667
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\options" -Name "DefaultFormat" -Value ”27” -PropertyType "Dword"
#V-70669
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security" -Name "PowerPointBypassEncryptedMacroScan" 
#V-70671
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security" -Name "AccessVBOM" -Value ”0” -PropertyType "Dword"
#V-70677
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security" -Name "RunPrograms" 
#V-70679
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security\protectedview" -Name "DisableAttachmentsInPV" -Value ”0” -PropertyType "Dword"
#V-70681
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security" -Name "VBAWarnings" -Value ”2” -PropertyType "Dword"
#V-70701
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\PowerPoint\security" -Name "blockcontentexecutionfrominternet" -Value ”1” -PropertyType "Dword"
#V-71043
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\fileblock" -Name "OpenInProtectedView" -Value ”0” -PropertyType "Dword"
#V-71049
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\filevalidation" -Name "EnableOnLoad" -Value ”1” -PropertyType "Dword"
#V-71051
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\protectedview" -Name "DisableInternetFilesInPV" -Value ”0” -PropertyType "Dword"
#V-71059
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security" -Name "RequireAddinSig" -Value ”1” -PropertyType "Dword"
#V-71063
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security" -Name "NoTBPromptUnsignedAddin" -Value ”1” -PropertyType "Dword"
#V-71067
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\trusted locations" -Name "AllLocationsDisabled" -Value ”1” -PropertyType "Dword"
#V-71069
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\trusted locations" -Name "AllowNetworkLocations" -Value ”0” -PropertyType "Dword"
#V-71071
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\options" -Name "DefaultFormat" -Value ”” -PropertyType "String"
#V-71073
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security" -Name "WordBypassEncryptedMacroScan" 
#V-71075
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security" -Name "AccessVBOM" -Value ”0” -PropertyType "Dword"
#V-71081
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\protectedview" -Name "DisableUnsafeLocationsInPV" 
#V-71083
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\filevalidation" -Name "openinprotectedview" -Value ”1” -PropertyType "Dword"
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\filevalidation" -Name "DisableEditFromPV" -Value ”1” -PropertyType "Dword"
#V-71085
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\protectedview" -Name "DisableAttachmentsInPV" -Value ”0” -PropertyType "Dword"
#V-71087
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\options" -Name "DontUpdateLinks" -Value ”1” -PropertyType "Dword"
#V-71089
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security" -Name "VBAWarnings" -Value ”2” -PropertyType "Dword"
#V-71091
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\common\research\translation" -Name "useonline" -Value ”0” -PropertyType "Dword"
#V-71093
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\fileblock" -Name "Word2Files" -Value ”2” -PropertyType "Dword"
#V-71095
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\fileblock" -Name "Word2000Files" -Value ”5” -PropertyType "Dword"
#V-71097
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\fileblock" -Name "Wor60Files" -Value ”2” -PropertyType "Dword"
#V-71099
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\fileblock" -Name "Word95Files" -Value ”5” -PropertyType "Dword"
#V-71101
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\fileblock" -Name "Word97Files" -Value ”5” -PropertyType "Dword"
#V-71103
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security\fileblock" -Name "WordXPFiles" -Value ”5” -PropertyType "Dword"
#V-71107
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\word\security" -Name "blockcontentexecutionfrominternet" -Value ”1” -PropertyType "Dword"

#V-70957
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL4Macros" -Value ”2” -PropertyType "Dword"
#V-70959
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL4Workbooks" -Value ”2” -PropertyType "Dword"
#V-70961
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL4Worksheets" -Value ”2” -PropertyType "Dword"
#V-70963
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL95Workbooks" -Value ”5” -PropertyType "Dword"
#V-70965
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL9597WorksbooksandTemplates" -Value ”5” -PropertyType "Dword"
#V-70967
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "OpenInProtectedView" -Value ”0” -PropertyType "Dword"
#V-70971
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "DifandSylkFiles" -Value ”2” -PropertyType "Dword"
#V-70973
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL2Macros" -Value ”2” -PropertyType "Dword"
#V-70975
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL2Worksheets" -Value ”2” -PropertyType "Dword"
#V-70977
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL3Macros" -Value ”2” -PropertyType "Dword"
#V-70979
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "XL3Worksheets" -Value ”2” -PropertyType "Dword"
#V-70983
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\filevalidation" -Name "EnableOnLoad" -Value ”1” -PropertyType "Dword"
#V-70985
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "HtmlandXmlssFiles" -Value ”2” -PropertyType "Dword"
#V-70987
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\protectedview" -Name "DisableInterFilesInPV" 
#V-70989
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\fileblock" -Name "DBaseFiles" -Value ”2” -PropertyType "Dword"
#V-70997
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security" -Name "RequireAddinSig" -Value ”1” -PropertyType "Dword"
#V-71001
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security" -Name "NoTBPromptUnsignedAddin" -Value ”1” -PropertyType "Dword"
#V-71005
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\trusted locations" -Name "AllLocationsDisabled" -Value ”1” -PropertyType "Dword"
#V-71007
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\trusted locations" -Name "AllowNetworkLocations" -Value ”0” -PropertyType "Dword"
#V-71011
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\options" -Name "DefaultFormat" -Value ”51” -PropertyType "Dword"
#V-71015
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security" -Name "ExcelBypassEncryptedMacroScan" 
#V-71017
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\options\binaryoptions" -Name "fGlobalSheet_37_1" -Value ”1” -PropertyType "Dword"
#V-71019
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security" -Name "AccessVBOM" -Value ”0” -PropertyType "Dword"
#V-71027
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\protectedview" -Name "DisableUnsafeLocationsInPV"
#V-71029
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\filevalidation" -Name "openinprotectedview" 
#V-71031
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security\protectedview" -Name "DisableAttachmentsInPV" -Value ”0” -PropertyType "Dword"
#V-71033
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security" -Name "vbawarnings" -Value ”2” -PropertyType "Dword"
#V-71035
Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security" -Name "webservicefunctionwarnings" 
#V-71037
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\options" -Name "extractdatadisableui" -Value ”1” -PropertyType "Dword"
#V-71039
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\office\16.0\excel\security" -Name "blockcontentexecutionfrominternet" -Value ”1” -PropertyType "Dword"
#V-46807
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Internet Explorer\Main" -Name "UseFormSuggest" -Value ”no” -PropertyType "String"
#V-46815
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Internet Explorer\Main" -Name "FormSuggestPasswords" -Value ”no” -PropertyType "String"
#V-70751
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\publisher\security" -Name "RequireAddinSig" -Value ”1” -PropertyType "Dword"
#V-70755
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\publisher\security" -Name "NoTBPromptUnsignedAddin" -Value ”1” -PropertyType "Dword"
#V-70763
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\publisher\security" -Name "VBAWarnings" -Value ”2” -PropertyType "Dword"
#V-63841
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation"




<#THESE ARE ALL LOCAL MACHINE REGISTRY VALUES.
Deletes every registry property and val that needs to be changed or modified during STIGing
Some pop as errors, depending if the computer has the registry key / value or not. Not a problem, as the script runs through and creates / modifies in compliance with the STIGs.
#>

New-Item -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC"
New-Item -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown"
New-Item -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cServices"
New-Item -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cCloud"
New-Item -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\AVGeneral"

Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown" -Name "bEnhancedSecurityStandalone" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "AutoPlayWhitelist"
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown" -Name "bEnhancedSecurityInBrowser" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown" -Name "iFileAttachmentPerms" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown" -Name "bEnableFlash" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cCloud" -Name "bEnhancedSecurityStandalone" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown" -Name "bDisableTrustedFolders" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\AVGeneral" -Name "bFIPSMode" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown" -Name "bProtectedMode" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown" -Name "iProtectedView" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cCloud" -Name "bDisableADCFileStore" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cServices" -Name "bTogglePrefsSync" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "Secure Protocols" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown" -Name "bEnhancedSecurityStandalone" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown" -Name "bEnhancedSecurityInBrowser" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown" -Name "iFileAttachmentPerms" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown" -Name "bEnableFlash" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown\cCloud" -Name "bAdobeSendPluginToggle" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown" -Name "bDisableTrustedFolders"
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown" -Name "bProtectedMode" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown" -Name "iProtectedView" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown\cCloud" -Name "bDisableADCFileStore" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown\cServices" -Name "bTogglePrefsSync" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cCloud" -Name "bAdobeSendPluginToggle" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "RemoteAccessHostFirewallTraversal" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "DefaultSearchProviderSearchURL" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "DownloadRestrictions" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "SSLVersionMin" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "ChromeCleanupEnabled" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "ChromeCleanupReportingEnabled" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "msaccess.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "msaccess.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "msaccess.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "msaccess.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "msaccess.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "msaccess.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "msaccess.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "msaccess.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "msaccess.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "msaccess.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "groove.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "groove.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "groove.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "groove.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "groove.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "groove.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "groove.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "groove.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "groove.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "groove.exe"
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\OneDrive\Remote Access" -Name "GPOEnabled" 
Remove-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\OneDrive\Remote Access" -Name "GPOEnabled" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "onenote.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "onenote.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "onenote.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "onenote.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "onenote.exe"
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "onenote.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "onenote.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "onenote.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "onenote.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "onenote.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "outlook.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "outlook.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "outlook.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "outlook.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "outlook.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "outlook.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "outlook.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "outlook.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "outlook.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "outlook.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "powerpnt.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "powerpnt.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "powerpnt.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "powerpnt.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "powerpnt.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "powerpnt.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "powerpnt.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "powerpnt.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "pptview.exe"
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "pptview.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "pptview.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "pptview.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "pptview.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "pptview.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "pptview.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "pptview.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "pptview.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "powerpnt.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "powerpnt.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "pptview.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\office\16.0\lync" -Name "savepassword"
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\office\16.0\lync" -Name "enablesiphighsecuritymode" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\office\16.0\lync" -Name "disablehttpconnect"
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "winword.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "winword.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "winword.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "winword.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "winword.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "winword.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "winword.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "winword.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "winword.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "winword.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\.NETFramework" -Name "AllowStrongNameBypass" 
Remove-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\.NETFramework" -Name "AllowStrongNameBypass" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "excel.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "excel.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "excel.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "excel.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "excel.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "excel.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "excel.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "excel.exe"
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "excel.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "excel.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\internet explorer\Main" -Name "Isolation64Bit" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "mspub.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "mspub.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "mspub.exe"
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "mspub.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "mspub.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "mspub.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "mspub.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "mspub.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "mspub.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "mspub.exe" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\WinRM\Client" -Name "AllowDigest" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreenCamera" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\PassportForWork" -Name "RequireSecurityDevice" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Cryptography\Configuration\SSL\00010002" -Name "EccCurves" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\OneDrive\AllowTenantList" -Name "1111-2222-3333-4444" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoiceAboveLock" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoice" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\FVE" -Name "UseAdvancedStartup" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\FVE" -Name "UseTPMPIN" 
Remove-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\FVE" -Name "UseTPMKeyPIN" 


#Creates new registry paths for the STIGs, as these are not default on some systems and must be created.
#After they're created, the new values are added inside the keys.
#The values removed above are also recreated with correct values here. 
#STIG Number is annotated ABOVE the command

#V-81589
New-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "AutoplayWhitelist" -Value ”[*.]mil [*.]gov” -PropertyType "String"
#V-79359
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown" -Name "bEnhancedSecurityStandalone" -Value ”1” -PropertyType "Dword"
#V-79361
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown" -Name "bEnhancedSecurityInBrowser" -Value ”1” -PropertyType "Dword"
#V-79363
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown" -Name "iFileAttachmentPerms" -Value ”1” -PropertyType "Dword"
#V-79369
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown" -Name "bEnableFlash" -Value ”0” -PropertyType "Dword"
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cCloud" -Name "bEnhancedSecurityStandalone" -Value ”1” -PropertyType "Dword"
#V-79373
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown" -Name "bDisableTrustedFolders" -Value ”1” -PropertyType "Dword"
#V-79375
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\AVGeneral" -Name "bFIPSMode" -Value ”1” -PropertyType "Dword"
#V-79379
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown" -Name "bProtectedMode" -Value ”1” -PropertyType "Dword"
#V-79381
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown" -Name "iProtectedView" -Value ”2” -PropertyType "Dword"
#V-79387
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cCloud" -Name "bDisableADCFileStore" -Value ”1” -PropertyType "Dword"
#V-79389
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cServices" -Name "bTogglePrefsSync" -Value ”1” -PropertyType "Dword"
#V-46473
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "Secure Protocols" -Value ”2560” -PropertyType "Dword"
#V-80111
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown" -Name "bEnhancedSecurityStandalone" -Value ”1” -PropertyType "Dword"
#V-80113          
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown" -Name "bEnhancedSecurityInBrowser" -Value ”1” -PropertyType "Dword"
#V-80115
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown" -Name "iFileAttachmentPerms" -Value ”1” -PropertyType "Dword"
#V-80121
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown" -Name "bEnableFlash" -Value ”0” -PropertyType "Dword"
#V-80123
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown\cCloud" -Name "bAdobeSendPluginToggle" -Value ”1” -PropertyType "Dword"
#V-80125
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown" -Name "bDisableTrustedFolders" -Value ”1” -PropertyType "Dword"
#V-80131
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown" -Name "bProtectedMode" -Value ”1” -PropertyType "Dword"
#V-80133
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown" -Name "iProtectedView" -Value ”2” -PropertyType "Dword"
#V-80139
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown\cCloud" -Name "bDisableADCFileStore" -Value ”1” -PropertyType "Dword"
#V-80141
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\2015\FeatureLockDown\cServices" -Name "bTogglePrefsSync" -Value ”1” -PropertyType "Dword"
#V-79371
New-ItemProperty -Path "HKLM:\Software\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cCloud" -Name "bAdobeSendPluginToggle" -Value ”1” -PropertyType "Dword"
#V-44711
New-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "RemoteAccessHostFirewallTraversal" -Value ”0” -PropertyType "Dword"
#V-44735
New-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "DefaultSearchProviderSearchURL" -Value ”https://www.google.com/#q={searchTerms}” -PropertyType "String"
#V-79931
New-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "DownloadRestrictions" -Value ”1” -PropertyType "Dword"
#V-81583
New-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "SSLVersionMin" -Value ”tls1.1” -PropertyType "String"
#V-81591
New-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "ChromeCleanupEnabled" -Value ”0” -PropertyType "Dword"
#V-81593
New-ItemProperty -Path "HKLM:\Software\Policies\Google\Chrome" -Name "ChromeCleanupReportingEnabled" -Value ”0” -PropertyType "Dword"
#V-70907
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "msaccess.exe" -Value ”1” -PropertyType "Dword"
#V-70925
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "msaccess.exe" -Value ”1” -PropertyType "Dword"
#V-70927
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "msaccess.exe" -Value ”1” -PropertyType "Dword"
#V-70929
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "msaccess.exe" -Value ”1” -PropertyType "Dword"
#V-70931
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "msaccess.exe" -Value ”1” -PropertyType "Dword"
#V-70933
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "msaccess.exe" -Value ”1” -PropertyType "Dword"
#V-70937
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "msaccess.exe" -Value ”1” -PropertyType "Dword"
#V-70943
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "msaccess.exe" -Value ”1” -PropertyType "Dword"
#V-70949
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "msaccess.exe" -Value ”1” -PropertyType "Dword"
#V-70951
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "msaccess.exe" -Value ”1” -PropertyType "Dword"
#V-71297
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "groove.exe" -Value ”1” -PropertyType "Dword"
#v-71301
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "groove.exe" -Value ”1” -PropertyType "Dword"
#v-71303
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "groove.exe" -Value ”1” -PropertyType "Dword"
#V-71305
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "groove.exe" -Value ”1” -PropertyType "Dword"
#V-71309
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "groove.exe" -Value ”1” -PropertyType "Dword"
#V-71311
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "groove.exe" -Value ”1” -PropertyType "Dword"
#V-71313
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "groove.exe" -Value ”1” -PropertyType "Dword"
#V-71317
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "groove.exe" -Value ”1” -PropertyType "Dword"
#V-71319
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "groove.exe" -Value ”1” -PropertyType "Dword"
#V-71321
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "groove.exe" -Value ”1” -PropertyType "Dword"
#V-71323
New-ItemProperty -Path "HKLM:\Software\Microsoft\OneDrive\Remote Access" -Name "GPOEnabled" -Value ”1” -PropertyType "Dword"
#V-71327
New-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\OneDrive\Remote Access" -Name "GPOEnabled" -Value ”1” -PropertyType "Dword"
#V-70829
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "onenote.exe" -Value ”1” -PropertyType "Dword"
#V-70831
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "onenote.exe" -Value ”1” -PropertyType "Dword"
#V-70833
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "onenote.exe" -Value ”1” -PropertyType "Dword"
#V-70835
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "onenote.exe" -Value ”1” -PropertyType "Dword"
#V-70837
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "onenote.exe" -Value ”1” -PropertyType "Dword"
#V-70839
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "onenote.exe" -Value ”1” -PropertyType "Dword"
#V-70841
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "onenote.exe" -Value ”1” -PropertyType "Dword"
#V-70843
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "onenote.exe" -Value ”1” -PropertyType "Dword"
#V-70845
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "onenote.exe" -Value ”1” -PropertyType "Dword"
#V-70847
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "onenote.exe" -Value ”1” -PropertyType "Dword"
#V-71109
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "outlook.exe" -Value ”1” -PropertyType "Dword"
#V-71111
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "outlook.exe" -Value ”1” -PropertyType "Dword"
#V-71113
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "outlook.exe" -Value ”1” -PropertyType "Dword"
#V-71115
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "outlook.exe" -Value ”1” -PropertyType "Dword"
#V-71117
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "outlook.exe" -Value ”1” -PropertyType "Dword"
#V-71119
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "outlook.exe" -Value ”1” -PropertyType "Dword"
#V-71121
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "outlook.exe" -Value ”1” -PropertyType "Dword"
#V-71123
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "outlook.exe" -Value ”1” -PropertyType "Dword"
#V-71125
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "outlook.exe" -Value ”1” -PropertyType "Dword"
#V-71127
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "outlook.exe" -Value ”1” -PropertyType "Dword"
#V-70641
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "powerpnt.exe" -Value ”1” -PropertyType "Dword"
#V-70645
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "powerpnt.exe" -Value ”1” -PropertyType "Dword"
#V-70647
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "powerpnt.exe" -Value ”1” -PropertyType "Dword"
#V-70653
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "powerpnt.exe" -Value ”1” -PropertyType "Dword"
#V-70657
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "powerpnt.exe" -Value ”1” -PropertyType "Dword"
#V-70661
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "powerpnt.exe" -Value ”1” -PropertyType "Dword"
#V-70673
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "powerpnt.exe" -Value ”1” -PropertyType "Dword"
#V-70675
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "powerpnt.exe" -Value ”1” -PropertyType "Dword"
#V-70683
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "pptview.exe" -Value ”1” -PropertyType "Dword"
#V-70685
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "pptview.exe" -Value ”1” -PropertyType "Dword"
#V-70687
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "pptview.exe" -Value ”1” -PropertyType "Dword"
#V-70689
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "pptview.exe" -Value ”1” -PropertyType "Dword"
#V-70691
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "pptview.exe" -Value ”1” -PropertyType "Dword"
#V-70693
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "pptview.exe" -Value ”1” -PropertyType "Dword"
#V-70695
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "pptview.exe" -Value ”1” -PropertyType "Dword"
#V-70697
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "pptview.exe" -Value ”1” -PropertyType "Dword"
#V-70699
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "pptview.exe" -Value ”1” -PropertyType "Dword"
#V-71401
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "powerpnt.exe" -Value ”1” -PropertyType "Dword"
#V-71403
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "powerpnt.exe" -Value ”1” -PropertyType "Dword"
#V-71647
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "pptview.exe" -Value ”1” -PropertyType "Dword"
#V-70901
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\office\16.0\lync" -Name "savepassword" -Value ”0” -PropertyType "Dword"
#V-70903
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\office\16.0\lync" -Name "enablesiphighsecuritymode" -Value ”1” -PropertyType "Dword"
#V-70905
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\office\16.0\lync" -Name "disablehttpconnect" -Value ”1” -PropertyType "Dword"
#V-71041
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "winword.exe" -Value ”1” -PropertyType "Dword"
#V-71045
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "winword.exe" -Value ”1” -PropertyType "Dword"
#V-71047
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "winword.exe" -Value ”1” -PropertyType "Dword"
#V-71053
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "winword.exe" -Value ”1” -PropertyType "Dword"
#V-71055
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "winword.exe" -Value ”1” -PropertyType "Dword"
#V-71057
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "winword.exe" -Value ”1” -PropertyType "Dword"
#V-71061
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "winword.exe" -Value ”1” -PropertyType "Dword"
#V-71065
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "winword.exe" -Value ”1” -PropertyType "Dword"
#V-71077
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "winword.exe" -Value ”1” -PropertyType "Dword"
#V-71079
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "winword.exe" -Value ”1” -PropertyType "Dword"
#V-7055
Remove-Item -Path 'HKLM:\Software\Microsoft\StrongName\Verification' -Recurse
#V-30935
New-ItemProperty -Path "HKLM:\Software\Microsoft\.NETFramework" -Name "AllowStrongNameBypass" -Value ”0” -PropertyType "Dword"
New-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\.NETFramework" -Name "AllowStrongNameBypass" -Value ”0” -PropertyType "Dword"
#V-70955
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "excel.exe" -Value ”1” -PropertyType "Dword"
#V-70969
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "excel.exe" -Value ”1” -PropertyType "Dword"
#V-70981
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "excel.exe" -Value ”1” -PropertyType "Dword"
#V-70991
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "excel.exe" -Value ”1” -PropertyType "Dword"
#V-70993
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "excel.exe" -Value ”1” -PropertyType "Dword"
#V-70995
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "excel.exe" -Value ”1” -PropertyType "Dword"
#V-70999
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "excel.exe" -Value ”1” -PropertyType "Dword"
#V-71003
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "excel.exe" -Value ”1” -PropertyType "Dword"
#V-71023
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "excel.exe" -Value ”1” -PropertyType "Dword"
#V-71025
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "excel.exe" -Value ”1” -PropertyType "Dword"
#V-46995
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\internet explorer\Main" -Name "Isolation64Bit" -Value ”1” -PropertyType "Dword"
#V-70729
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_HTTP_USERNAME_PASSWORD_DISABLE" -Name "mspub.exe" -Value ”1” -PropertyType "Dword"
#V-70731
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_SAFE_BINDTOOBJECT" -Name "mspub.exe" -Value ”1” -PropertyType "Dword"
#V-70733
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_UNC_SAVEDFILECHECK" -Name "mspub.exe" -Value ”1” -PropertyType "Dword"
#V-70735
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_VALIDATE_NAVIGATE_URL" -Name "mspub.exe" -Value ”1” -PropertyType "Dword"
#V-70747
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WINDOW_RESTRICTIONS" -Name "mspub.exe" -Value ”1” -PropertyType "Dword"
#V-70749
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ADDON_MANAGEMENT" -Name "mspub.exe" -Value ”1” -PropertyType "Dword"
#V-70753
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_WEBOC_POPUPMANAGEMENT" -Name "mspub.exe" -Value ”1” -PropertyType "Dword"
#V-70757
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_FILEDOWNLOAD" -Name "mspub.exe" -Value ”1” -PropertyType "Dword"
#V-70759
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ZONE_ELEVATION" -Name "mspub.exe" -Value ”1” -PropertyType "Dword"
#V-70761
New-ItemProperty -Path "HKLM:\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_RESTRICT_ACTIVEXINSTALL" -Name "mspub.exe" -Value ”1” -PropertyType "Dword"
#V-63341
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\WinRM\Client" -Name "AllowDigest" -Value ”0” -PropertyType "Dword"
#V-63545
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreenCamera" -Value ”1” -PropertyType "Dword"
#V-63717
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\PassportForWork" -Name "RequireSecurityDevice" -Value ”1” -PropertyType "Dword"
#V-74413
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Cryptography\Configuration\SSL\00010002" -Name "EccCurves" -Value ”NistP384 NistP256” -PropertyType "MultiString"
#V-88203
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\OneDrive\AllowTenantList" -Name "1111-2222-3333-4444" -Value ”1111-2222-3333-4444” -PropertyType "String"
#V-94719
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoiceAboveLock" -Value ”2” -PropertyType "Dword"
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoice" -Value ”2” -PropertyType "Dword"
#V-94859
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\FVE" -Name "UseAdvancedStartup" -Value ”1” -PropertyType "Dword"
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\FVE" -Name "UseTPMPIN" -Value ”1” -PropertyType "Dword"
New-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\FVE" -Name "UseTPMKeyPIN" -Value ”1” -PropertyType "Dword"
#V-44805
(Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo
Write-Output If this Google version is not greater than 74.X, then please download the latest version of Chrome.
#SOftware center google update maybe??????????????????

Set-Location C:\Windows\Microsoft.NET\Framework\v4.0.30319
$Pub = .\CasPol.exe -m -lg | Select-String "1.6"
if ($Pub -ne $var2) 
{Write-Output "Check with the IAO about if this cert publisher (Item 1.6) is approved by the IAO."}
}
#$NotFrankensteins = Get-Content C:\Users\1368213965a.adw\Desktop\theseAREALIVE.txt
#foreach ($NotFrankenstein in $NotFrankensteins) {
#Getmac /S $NotFrankenstein >> C:\Users\1368213965a.adw\Desktop\MAC.txt
}
