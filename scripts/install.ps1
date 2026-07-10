[CmdletBinding()]
param(
    [string]$Target = (Join-Path $HOME '.codex'),
    [string]$Repository = 'https://github.com/FrauJulian/.codex.git'
)

$ErrorActionPreference = 'Stop'

if (Test-Path -LiteralPath (Join-Path $Target '.git')) {
    throw "Eine Installation existiert bereits in '$Target'. Verwende update.ps1."
}

if (Test-Path -LiteralPath $Target) {
    $backup = "$Target.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Move-Item -LiteralPath $Target -Destination $backup
    Write-Host "Backup: $backup"
}

git clone -- $Repository $Target
& (Join-Path $Target 'scripts\validate.ps1')
Write-Host 'Installation geprüft. Führe anschließend codex login aus.'
