[CmdletBinding()]
param([string]$RepositoryRoot = (Split-Path -Parent $PSScriptRoot))

$ErrorActionPreference = 'Stop'
$config = Join-Path $RepositoryRoot 'config.toml'

if (-not (Test-Path -LiteralPath $config)) {
    throw 'config.toml fehlt.'
}

$forbidden = Select-String -Path $config -Pattern '\[projects\.', '^trust_level\s*=', '^[A-Za-z]:\\', '\[hooks\.state\]'
if ($forbidden) {
    $forbidden | ForEach-Object { Write-Error "Nicht portable Konfiguration: $($_.Line.Trim())" }
    exit 1
}

Get-ChildItem -LiteralPath (Join-Path $RepositoryRoot 'skills') -Directory |
    Where-Object Name -ne '.system' |
    ForEach-Object {
        if (-not (Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md'))) {
            throw "SKILL.md fehlt in '$($_.FullName)'."
        }
    }

Write-Host 'Validierung erfolgreich.'
