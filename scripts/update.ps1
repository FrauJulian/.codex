[CmdletBinding()]
param([string]$RepositoryRoot = (Split-Path -Parent $PSScriptRoot))

$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $RepositoryRoot

if (git status --porcelain) {
    throw 'Der Arbeitsbaum ist nicht sauber. Änderungen zuerst committen oder sichern.'
}

git pull --ff-only
& (Join-Path $PSScriptRoot 'validate.ps1') -RepositoryRoot $RepositoryRoot
