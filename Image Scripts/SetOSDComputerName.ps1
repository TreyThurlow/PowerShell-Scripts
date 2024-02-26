$ComputerName = Get-Content -Path "X:\ComputerName.txt"

$TSEnv = New-Object -ComObject Microsoft.SMS.TSEnvironment
$TSEnv.Value("OSDComputerName") = $ComputerName
