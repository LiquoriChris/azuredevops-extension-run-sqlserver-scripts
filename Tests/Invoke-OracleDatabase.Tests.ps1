Describe 'Install-DbaTools' {
    Context 'dbatools module test' {
        It 'Should have dbatools module installed' {
            {Get-InstalledModule -Name dbatools} |Should Not throw
        }
    }
}