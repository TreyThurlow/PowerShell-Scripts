#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
# This script will take an already filled out STIG Checklist and change the computer name and MAC Address to match the correct computer. This script is to be ran after 
# the FullSTIGScript.ps1 script.
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
$date = Get-Date -Format ddMMMyy
$incre = 0
$incre1 = 0
$hostys = Get-Content C:\Users\USERNAME\Desktop\theseAREALIVE.txt
$yalls = Get-Content C:\Users\USERNAME\Desktop\MAC.txt
$mymy = (Get-Content .\MAC.txt -TotalCount 1)
$mymy2 = (Get-Content .\MAC.txt -TotalCount 2)[-1]
$mymy3 = (Get-Content .\MAC.txt -TotalCount 3)[-1]
$mymy4 = (Get-Content .\MAC.txt -TotalCount 4)[-1]
$mymy5 = (Get-Content .\MAC.txt -TotalCount 5)[-1]
$mymy6 = (Get-Content .\MAC.txt -TotalCount 6)[-1]
$mymy7 = (Get-Content .\MAC.txt -TotalCount 7)[-1]
$mymy8 = (Get-Content .\MAC.txt -TotalCount 8)[-1]
$mymy9 = (Get-Content .\MAC.txt -TotalCount 9)[-1]
$mymy10 = (Get-Content .\MAC.txt -TotalCount 10)[-1]
$mymy11 = (Get-Content .\MAC.txt -TotalCount 11)[-1]
$mymy12 = (Get-Content .\MAC.txt -TotalCount 12)[-1]
$mymy13 = (Get-Content .\MAC.txt -TotalCount 13)[-1]
$mymy14 = (Get-Content .\MAC.txt -TotalCount 14)[-1]
$mymy15 = (Get-Content .\MAC.txt -TotalCount 15)[-1]
$mymy16 = (Get-Content .\MAC.txt -TotalCount 16)[-1]
$mymy17 = (Get-Content .\MAC.txt -TotalCount 17)[-1]
$mymy18 = (Get-Content .\MAC.txt -TotalCount 18)[-1]
$mymy19 = (Get-Content .\MAC.txt -TotalCount 19)[-1]
$mymy20 = (Get-Content .\MAC.txt -TotalCount 20)[-1]
$mymy21 = (Get-Content .\MAC.txt -TotalCount 21)[-1]
$mymy22 = (Get-Content .\MAC.txt -TotalCount 22)[-1]
$mymy23 = (Get-Content .\MAC.txt -TotalCount 23)[-1]
$mymy24 = (Get-Content .\MAC.txt -TotalCount 24)[-1]
$mymy25 = (Get-Content .\MAC.txt -TotalCount 25)[-1]
$mymy26 = (Get-Content .\MAC.txt -TotalCount 26)[-1]
$mymy27 = (Get-Content .\MAC.txt -TotalCount 27)[-1]
$mymy28 = (Get-Content .\MAC.txt -TotalCount 28)[-1]
$mymy29 = (Get-Content .\MAC.txt -TotalCount 29)[-1]
$mymy30 = (Get-Content .\MAC.txt -TotalCount 30)[-1]
$mymy31 = (Get-Content .\MAC.txt -TotalCount 31)[-1]
$mymy32 = (Get-Content .\MAC.txt -TotalCount 32)[-1]
$mymy33 = (Get-Content .\MAC.txt -TotalCount 33)[-1]
$mymy34 = (Get-Content .\MAC.txt -TotalCount 34)[-1]
$mymy35 = (Get-Content .\MAC.txt -TotalCount 35)[-1]
$mymy36 = (Get-Content .\MAC.txt -TotalCount 36)[-1]
$mymy37 = (Get-Content .\MAC.txt -TotalCount 37)[-1]
$mymy38 = (Get-Content .\MAC.txt -TotalCount 38)[-1]
$mymy39 = (Get-Content .\MAC.txt -TotalCount 39)[-1]
$mymy40 = (Get-Content .\MAC.txt -TotalCount 40)[-1]
$mymy41 = (Get-Content .\MAC.txt -TotalCount 41)[-1]
$mymy42 = (Get-Content .\MAC.txt -TotalCount 42)[-1]
$mymy43 = (Get-Content .\MAC.txt -TotalCount 43)[-1]
$mymy44 = (Get-Content .\MAC.txt -TotalCount 44)[-1]
$mymy45 = (Get-Content .\MAC.txt -TotalCount 45)[-1]
$mymy46 = (Get-Content .\MAC.txt -TotalCount 46)[-1]
$mymy47 = (Get-Content .\MAC.txt -TotalCount 47)[-1]
$mymy48 = (Get-Content .\MAC.txt -TotalCount 48)[-1]
$mymy49 = (Get-Content .\MAC.txt -TotalCount 49)[-1]
$mymy50 = (Get-Content .\MAC.txt -TotalCount 50)[-1]
$mymy51 = (Get-Content .\MAC.txt -TotalCount 51)[-1]
$mymy52 = (Get-Content .\MAC.txt -TotalCount 52)[-1]
$mymy53 = (Get-Content .\MAC.txt -TotalCount 53)[-1]
$mymy54 = (Get-Content .\MAC.txt -TotalCount 54)[-1]
$mymy55 = (Get-Content .\MAC.txt -TotalCount 55)[-1]
$mymy56 = (Get-Content .\MAC.txt -TotalCount 56)[-1]

foreach ($hosty in $hostys)
{ 
$Script:incre++
Write-Host $Script:incre
(Get-Content C:\Users\USERNAME\Desktop\CHECKLISTFORSCRIPT.ckl) -replace 'CZQZL-031CKZ', $hosty | Set-Content C:\Users\USERNAME\Desktop\CompletedSTIGChecklists\9SOS_$($hosty)_$date.ckl
}
