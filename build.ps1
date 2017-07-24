Sconfig = ConvertFrom-JSON -InputObject (Get-Content .\config\EnvironmentConfig.json -raw)
New-Item C:\github\app-lab\backups\RestoreTimeClean\ -ItemType Directory
#restoretimeClean
$instance = $config.EnvironmentConfig | Where-Object {$_.EnvironmentName -eq $config.databases}
Invoke-SqlCmd -ServerInstance localhost\sql2016 -InputFile "C:\github\lab-build\buildscripts\RestoreTimeClean\RestoreTimeClean.sql" -QueryTimeout 0
