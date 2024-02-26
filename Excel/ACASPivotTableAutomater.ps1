<#
.SYNOPSIS
    Imports ACAS .csv results and automates the creation of Pivot Tables to easily see ACAS results. This script requires the use of the ImportExcel Module.
.NOTES
Author: SSgt Trey Thurlow, NPES NCOIC, JCA
#>

Import-Module ImportExcel

$Year = Get-Date -Format "yyyy"
$Month = Get-Date -Format "MMM yyyy"
$TodayDate = Get-Date -Format "dd MMM yyyy"
$RawACASScanFilePath = "\\server\folder1\Scans\ACAS" 

$WKSResults = "$RawACASScanFilePath\$Year\$Month\$TodayDate\wks.csv"
$DCResults = "$RawACASScanFilePath\$Year\$Month\$TodayDate\dc.csv"
$MSResults = "$RawACASScanFilePath\$Year\$Month\$TodayDate\mbr.csv"


$ReportPath = "SET\LOCATION\OF\FINAL\FILE"
$FileDate = Get-Date -Format "yyyy-MM-dd"
$ResultFile = $ReportPath + "ACAS Results Sorted" + "_" + $FileDate + ".xlsx"

Import-CSV $WKSResults | Export-Excel $ResultFile -WorksheetName "WKS Results" -Autosize
Import-Csv $DCResults | Export-Excel $ResultFile -WorksheetName "DC Results" -Autosize
Import-Csv $MSResults | Export-Excel $ResultFile -WorksheetName "MS Results" -Autosize

$excel = Open-ExcelPackage -Path $ResultFile -KillExcel

Add-PivotTable -ExcelPackage $excel -PivotRows "Plugin Name", "Plugin Output", "DNS Name" -SourceWorkSheet "WKS Results" -PivotTableName "WKS Results"
Add-PivotTable -ExcelPackage $excel -PivotRows "Plugin Name", "Plugin Output", "DNS Name" -SourceWorkSheet "DC Results" -PivotTableName "DC Results"
Add-PivotTable -ExcelPackage $excel -PivotRows "Plugin Name", "Plugin Output", "DNS Name" -SourceWorkSheet "MS Results" -PivotTableName "MS Results"

Close-ExcelPackage -ExcelPackage $excel -Show
