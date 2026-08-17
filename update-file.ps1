param(
    [Parameter(Mandatory=$true)][string]$SourcePath,
    [Parameter(Mandatory=$true)][string]$TargetRelativePath,
    [Parameter(Mandatory=$true)][string]$CommitMessage
)

$repoRoot = $PSScriptRoot
$targetFullPath = Join-Path $repoRoot $TargetRelativePath
$targetDir = Split-Path $targetFullPath -Parent

# Create target folder if it doesn't exist
if (-not (Test-Path $targetDir)) {
    Write-Host "Creating folder: $targetDir" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $targetDir | Out-Null
}

Write-Host "Pulling latest..." -ForegroundColor Cyan
git -C $repoRoot pull

Write-Host "Copying $SourcePath -> $targetFullPath" -ForegroundColor Cyan
Copy-Item -Path $SourcePath -Destination $targetFullPath -Force

Write-Host "Committing and pushing..." -ForegroundColor Cyan
git -C $repoRoot add $TargetRelativePath
git -C $repoRoot commit -m $CommitMessage
git -C $repoRoot push

Write-Host "Done." -ForegroundColor Green
git -C $repoRoot log --oneline -3
