[CmdletBinding()]
param([string]$RepositoryRoot = (Split-Path -Parent $PSScriptRoot))

$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $RepositoryRoot

if (git status --porcelain) {
    throw 'The working tree is not clean. Commit or stash your changes first.'
}

git pull --ff-only
& (Join-Path $PSScriptRoot 'validate.ps1') -RepositoryRoot $RepositoryRoot
