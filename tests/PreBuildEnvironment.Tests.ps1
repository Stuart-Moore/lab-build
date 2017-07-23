
Describe "Pre Build Environment Tests" {
    Context "Test we have a valid config and Environment" {
        It "EnvironmentConfig.json should exist" {
            'c:\github\lab-build\config\EnvironmentConfig.json' | Should Exist
        }
        It "Config file should be valid JSON and import cleanly" {
            ($ErrorVar[0] -eq $null )| Should Be $True
            ($WarnVar[0] -eq $null) | Should Be $True    
        }
    }
}