param(
    [Parameter(Mandatory=$true)][string]$SourcePath,
    [Parameter(Mandatory=$true)][string]$TargetRelativePath,
    [Parameter(Mandatory=$true)][string]$CommitMessage
)

$repoRoot = $PSScriptRoot
$targetFullPath = Join-Path $repoRoot $TargetRelativePath

Write-Host "Pulling latest..." -ForegroundColor Cyan
git pull

Write-Host "Copying $SourcePath -> $targetFullPath" -ForegroundColor Cyan
Copy-Item -Path $SourcePath -Destination $targetFullPath -Force

Write-Host "Committing and pushing..." -ForegroundColor Cyan
git add $TargetRelativePath
git commit -m $CommitMessage
git push

Write-Host "Done." -ForegroundColor Green
git log --oneline -3