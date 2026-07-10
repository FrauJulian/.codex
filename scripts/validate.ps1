[CmdletBinding()]
param(
    [string]$RepositoryRoot = (Split-Path -Parent $PSScriptRoot),
    [switch]$Staged
)

$ErrorActionPreference = 'Stop'
$config = Join-Path $RepositoryRoot 'config.toml'

Set-Location -LiteralPath $RepositoryRoot

if ($Staged) {
    git diff --cached --check
    if ($LASTEXITCODE) { exit $LASTEXITCODE }

    $blockedNames = '(^|/)(auth\.json|cap_sid|installation_id|history\.jsonl|.*\.sqlite(?:-(?:shm|wal))?|.*\.pem)$'
    $names = git diff --cached --name-only --diff-filter=ACMR
    if ($names | Where-Object { $_ -match $blockedNames }) {
        Write-Error 'Gestagte Runtime-, Credential- oder Schlüsseldatei erkannt.'
        exit 1
    }

    $added = git diff --cached --no-ext-diff --unified=0 |
        Where-Object { $_ -match '^\+(?!\+\+\+)' -and $_ -notmatch 'allow-secret-scan' }
    $secretPatterns = @(
        '-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----', # allow-secret-scan
        '(?i)(?:api[_-]?key|token|secret|password)\s*[:=]\s*["''][A-Za-z0-9_\-]{16,}', # allow-secret-scan
        '(?:gh[pousr]_[A-Za-z0-9]{30,}|sk-[A-Za-z0-9_-]{20,})', # allow-secret-scan
        '\[projects\.', # allow-secret-scan
        '^\+\s*trust_level\s*=', # allow-secret-scan
        '\[hooks\.state\]', # allow-secret-scan
        '[A-Za-z]:\\Users\\[^\\\s]+' # allow-secret-scan
    )
    foreach ($pattern in $secretPatterns) {
        if ($added -match $pattern) {
            Write-Error "Gestagter Inhalt verletzt die Secret-/Portabilitätsrichtlinie: $pattern"
            exit 1
        }
    }
}

if (-not (Test-Path -LiteralPath $config)) {
    throw 'config.toml fehlt.'
}

$configContent = if ($Staged) { git show :config.toml } else { Get-Content -LiteralPath $config }
$forbidden = $configContent | Where-Object { $_ -match '\[projects\.|^trust_level\s*=|^[A-Za-z]:\\|\[hooks\.state\]' }
if ($forbidden) {
    $forbidden | ForEach-Object { Write-Error "Nicht portable Konfiguration: $($_.Trim())" }
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
