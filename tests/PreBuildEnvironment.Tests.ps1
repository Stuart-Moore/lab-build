
Describe "Pre Build Environment Tests" {
    Context "Test we have a valid config and Environment" {
        It "EnvironmentConfig.json should exist" {
            'c:\github\lab-build\config\EnvironmentConfig.json' | Should Exist
        }
        $config = ConvertFrom-JSON -InputObject (Get-Content -Path "c:\github\lab-build\config\EnvironmentConfig.json" -raw) -WarningVariable WarnVar -ErrorVariable ErrorVar    
        It "Config file should be valid JSON and import cleanly" {
            ($ErrorVar[0] -eq $null )| Should Be $True
            ($WarnVar[0] -eq $null) | Should Be $True    
        }
        It "Config should contain at least 2 environments" {
            $config.environments.count | Should BeGreaterThan 1
        }
        It "Config Should contain at least 5 databases" {
            $config.databases.count | Should BeGreaterThan 4
        }
    }
}