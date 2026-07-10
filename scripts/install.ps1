[CmdletBinding()]
param(
    [string]$Target = (Join-Path $HOME '.codex'),
    [string]$Repository = 'https://github.com/FrauJulian/.codex.git'
)

$ErrorActionPreference = 'Stop'

if (Test-Path -LiteralPath (Join-Path $Target '.git')) {
    throw "An installation already exists at '$Target'. Run update.ps1 instead."
}

if (Test-Path -LiteralPath $Target) {
    $backup = "$Target.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Move-Item -LiteralPath $Target -Destination $backup
    Write-Host "Backup: $backup"
}

git clone -- $Repository $Target
& (Join-Path $Target 'scripts\validate.ps1')
Write-Host 'Installation validated. Run codex login next.'
