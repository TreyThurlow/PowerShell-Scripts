Get-WmiObject win32_logicaldisk -Filter 'DriveType=5' | ForEach-Object {
    $Eject = New-Object -ComObject Shell.Application
    $Eject.Namespace(17).ParseName($_.DeviceID).InvokeVerb("Eject")
    [System.Runtime.InteropServices.Marshal]::ReleastComObject($Eject)
}
