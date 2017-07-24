$config = ConvertFrom-JSON -InputObject (Get-Content c:\github\lab-build\config\EnvironmentConfig.json -raw)
New-Item C:\github\app-lab\backups\RestoreTimeClean\ -ItemType Directory
New-Item C:\github\app-lab\backups\RestoreTimeStripe\ -ItemType Directory

#restoretimeClean
#$instance = $config.EnvironmentConfig | Where-Object {$_.EnvironmentName -eq $config.databases}
#$start = Get-date
#Invoke-SqlCmd -ServerInstance localhost\sql2016 -InputFile "C:\github\lab-build\buildscripts\RestoreTimeClean\RestoreTimeClean.sql" -QueryTimeout 0
#$end  = get-date
$span = ($end-$start).minutes
write-host "took $span minutes"

foreach ($database in $config.databases){
    $instance = $config.Environments | Where-Object {$_.EnvironmentName -eq $database.environment}
    If (test-path $database.script ) {
        Start-RsJob -Name {$database.DatabaseName} -ScriptBlock {
            Invoke-SqlCmd -ServerInstance $instance.InstanceName -InputFile $database.script -QueryTimeout 0
        } 
    }   
}

