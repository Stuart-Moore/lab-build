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

$config.databases |
    Start-RsJob -Name {$_.DatabaseName} -Batch 'dbcreation' -ScriptBlock {
        $instance = $config.Environments | Where-Object EnvironmentName -eq $_.environment
        If (test-path $_.script ) {
            write-host "running $($database.script)"
            Invoke-SqlCmd -ServerInstance $instance.InstanceName -InputFile $_.script -QueryTimeout 0 -Verbose
        } 
    }   

Get-RsJob -Batch 'dbcreation' | Wait-RsJob | Out-Null
Get-RsJob -Batch 'dbcreation' | Receive-RsJob
Get-RsJob -Batch 'dbcreation' | Remove-RsJob
