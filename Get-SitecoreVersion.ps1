#Set-StrictMode -Version Latest
#####################################################
# Get-SitecoreVersion
#####################################################
<#PSScriptInfo

.VERSION 0.1

.GUID d69d298c-4ab2-4879-ad49-0dc8cf49903a

.AUTHOR David Walker, Sitecore Dave, Radical Dave

.COMPANYNAME David Walker, Sitecore Dave, Radical Dave

.COPYRIGHT David Walker, Sitecore Dave, Radical Dave

.TAGS sitecore powershell get sitecore version

.LICENSEURI https://github.com/SitecoreDave/SharedSitecore.SitecoreLocal/blob/main/LICENSE

.PROJECTURI https://github.com/SitecoreDave/SharedSitecore.SitecoreLocal

.ICONURI

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES


#>

<#
.SYNOPSIS
PowerShell Script helper to Get Sitecore Version by Website root path

.DESCRIPTION
PowerShell Script helper to Get Sitecore Version by Website root path

.PARAMETER path
Path of site (or name of site in WWWROOT) - if empty returns list of all Sitecore sites within wwwroot

.EXAMPLE
PS> .\Get-SitecoreVersion [If no params calls Get-SitecoreSite]

.Link
https://github.com/SharedSitecore/Get-SitecoreVersion

.OUTPUTS
    System.String
#>
#####################################################
# Get-SitecoreSite
#####################################################
Param(
	# Path of site (or name of site in WWWROOT) - if empty returns list of all Sitecore sites within wwwroot
	[Parameter(Mandatory = $false, position=0)] [string]$path
)
begin {
	$ProgressPreference = 'SilentlyContinue'
	$ErrorActionPreference = 'Stop'
    $PSScriptName = ($MyInvocation.MyCommand.Name.Replace(".ps1",""))
    Write-Verbose "#####################################################"
    Write-Verbose "# $PSScriptName $path"    
}
process {
	Write-Verbose "$PSScriptName $path start"
    if (!$path) {
        if (-not (Get-Command -Name Get-SitecoreSite)) {Install-Script -Name Get-SitecoreSite -Confirm:$False -Force }
        $path = @(Get-SitecoreSite)?[0]
    } else {
        if (!(Test-Path $path)) {
            $path = Get-SitecoreSite $path
        }
    }

    [XML]$versionXml = Get-Content "$path/sitecore/shell/sitecore.version.xml"
    $results = "$($versionXml.information.version.major).$($versionXml.information.version.minor).$($versionXml.information.version.build)"

    Write-Verbose "results:$results"
    return $results
}