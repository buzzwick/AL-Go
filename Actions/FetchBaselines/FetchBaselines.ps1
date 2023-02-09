[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    $Project,
    [Parameter(Mandatory=$true)]
    $BuildMode
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 2.0
$baseFolder = $ENV:GITHUB_WORKSPACE

$projectPath = Join-Path $baseFolder $Project
$baselineScript = Join-Path $projectPath '.AL-Go/FetchBaselines.ps1'

if(-not (Test-Path $baselineScript)) {
  throw "Could not find baseline script for project $project"
}

try {
    . (Join-Path -Path $PSScriptRoot -ChildPath "..\AL-Go-Helper.ps1" -Resolve)
    $bcContainerHelperPath = DownloadAndImportBcContainerHelper -baseFolder $baseFolder

    Write-Host 'Executing custom script to fetch baselines'
    . $baselineScript -Project $project -BuildMode $buildMode
}
finally {
    CleanupAfterBcContainerHelper -bcContainerHelperPath $bcContainerHelperPath
}