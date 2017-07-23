
Context "Test we have a valid config and Environment" {
    Describe "EnvironmentConfig.json should exist" {
        "$PSScriptRoot\..\config\EnvironmentConfig.json" | Should Exist
    }
    $config = ConvertFrom-JSON -InputObject (Get-Content -Path "c:\github\lab-build\config\EnvironmentConfig.json" -raw) -WarningVariable WarnVar -ErrorVariable ErrorVar    
    Describe "Config file should be valid JSON and import cleanly" {
        ($ErrorVar[0] -eq $null )| Should Be True
        ($WarnVar[0] -eq $null) | Should Be True    
    }
    Describe "Config should contain at least 2 environments" {
        $config.environments.count | Should BeGreaterThan 1
    }
    Describe "Config Should contain at least 5 databases" {
        $config.databases.count | Should BeGreaterThan 4
    }
    ForEach ($Environment in $config.environments ){
        $sqlsvr = New-Object -TypeName  Microsoft.SQLServer.Management.Smo.Server($Environment.InstanceName)

        Describe "Environment $($Environment.EnvironmentName) should be connectable" {
            ($sqlsvr.Status -ne $null) | Should Be $True
        }
        if ($sqlsvr.Status -ne $null){
            Foreach ($Database in ($config.databases | Where-Object {$_.Environment -eq $Environment.EnvironmentName })) {
                Describe "$($Database.DatabaseName) Should Not exist on $($Environment.EnvironmentName)"{
                    ($Database.DatabaseName -in $sqlsvr.Databases.name) | Should be $False
                }
            }
        }
        else {
            Write-Host "Skipping Db checks as instance not available"
        }
    }
}