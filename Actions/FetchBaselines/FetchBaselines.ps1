[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    $Project,
    [Parameter(Mandatory=$true)]
    $BuildMode
)

$baseFolder = $ENV:GITHUB_WORKSPACE

$projectPath = Join-Path $baseFolder $Project
$baselineScript = Join-Path $projectPath '.AL-Go/FetchBaselines.ps1'

if(-not (Test-Path $baselineScript)) {
  throw "Could not find baseline script for project $project"
}

try {
    . (Join-Path -Path $PSScriptRoot -ChildPath "..\AL-Go-Helper.ps1" -Resolve)
    $BcContainerHelperPath = DownloadAndImportBcContainerHelper -baseFolder $baseFolder

    Write-Host 'Executing custom script to fetch baselines'
    . $baselineScript -Project $project -BuildMode $buildMode -Settings $settings
}
finally {
    CleanupAfterBcContainerHelper -bcContainerHelperPath $bcContainerHelperPath
}