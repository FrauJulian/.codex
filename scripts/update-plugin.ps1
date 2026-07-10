[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$Plugin = 'ponytail@ponytail',
    [string]$Marketplace = 'https://github.com/DietrichGebert/ponytail.git'
)

$ErrorActionPreference = 'Stop'
$config = Join-Path (Split-Path -Parent $PSScriptRoot) 'config.toml'
$current = (Select-String -Path $config -Pattern '^last_revision\s*=\s*"([0-9a-f]+)"').Matches.Groups[1].Value
$remoteLine = git ls-remote $Marketplace HEAD
if ($LASTEXITCODE -or -not $remoteLine) { throw 'Die Upstream-Revision konnte nicht ermittelt werden.' }
$remote = $remoteLine.Split("`t")[0]

Write-Host "Installiert/erfasst: $current"
Write-Host "Upstream HEAD:       $remote"

if ($current -eq $remote) {
    Write-Host 'Kein Update verfügbar.'
    return
}

if ($PSCmdlet.ShouldProcess("$Plugin auf $remote", 'Plugin aktualisieren')) {
    codex plugin add $Plugin
    codex plugin list
}
