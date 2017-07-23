
Describe "Pre Build Environment Tests" {
    Context "Test we have a valid config and Environment" {
        It "EnvironmentConfig.json should exist" {
            'c:\github\lab-build\config\EnvironmentConfig.json' | Should Exist
        }
    }
}