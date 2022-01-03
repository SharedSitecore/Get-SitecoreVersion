Describe 'Get-SitecoreVersion.Tests' {
    It 'passes empty' {
        .\Get-SitecoreVersion.ps1 | Should -Not -BeNullOrEmpty #If there is a Sitecore Site in WWWROOT
        $? | Should -Be $true
    }
    It 'passes bad' {
        {.\Get-SitecoreVersion.ps1 bad} | Should -Throw
    }
    It 'passes site' {
        $results = .\Get-SitecoreVersion sitecore.sc
        $results | Should -Not -BeLike '*error*'
        $? | Should -Be $true
        Write-Host "results:$results"
    }
}