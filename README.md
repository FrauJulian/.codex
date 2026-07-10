# Personal Codex configuration

Portable Codex setup for my own machines.

## What is shared

- `AGENTS.md` - global behavior instructions
- `config.toml` - model, agent limits, marketplace sources, plugin enablement
- `agents/` - custom subagent roles
- `skills/` - custom user skills
- marketplace and plugin selections via `config.toml`

Project-specific settings do not belong in this repository. Do not commit `[projects.*]` sections, `trust_level` entries, absolute local paths, or repository-specific defaults.

Current synced marketplace/plugin config:

- Marketplace `ponytail` from `https://github.com/DietrichGebert/ponytail.git`
- Enabled plugin `ponytail@ponytail`

## What is not shared

This repository intentionally excludes credentials, local runtime state, caches, logs, sessions, sandbox data, generated plugin caches, SQLite databases, and machine identity files.

Never commit:

- `auth.json`
- `cap_sid`
- `installation_id`
- machine-specific trusted project entries in `config.toml`
- TUI onboarding state such as `[tui.model_availability_nux]`
- local hook trust state under `[hooks.state]`
- `history.jsonl`
- `sessions/`
- `cache/`
- `plugins/` downloaded plugin cache and runtime data
- `packages/`
- `.sandbox*`
- `*.sqlite*`
- `*.log`

## Setup on another PC

Install Git and Codex, then close all Codex clients. Run the following commands from PowerShell:

```powershell
Set-Location $env:USERPROFILE

if (Test-Path -LiteralPath ".codex") {
    $backup = ".codex.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Rename-Item -LiteralPath ".codex" -NewName $backup -ErrorAction Stop
}

git clone https://github.com/FrauJulian/.codex.git ".codex"
Set-Location ".codex"
codex login
codex plugin add ponytail@ponytail
codex plugin list
codex --strict-config doctor --summary
```

The timestamped backup keeps the previous local credentials and runtime state available for manual recovery. `codex login` creates fresh authentication data; subsequent Codex starts recreate sessions, logs, caches, and plugin downloads. These files remain ignored by Git.

## Updating from GitHub

Pull the latest shared configuration on an existing installation:

```powershell
Set-Location "$env:USERPROFILE\.codex"
git pull --ff-only
codex plugin add ponytail@ponytail
codex plugin list
codex --strict-config doctor --summary
```

## Publishing local changes

Commit only intentional config changes:

```powershell
git status --short
git add AGENTS.md config.toml agents skills README.md .gitignore
git commit -m "Update Codex config"
git push
```

Before pushing, check that no secrets are staged:

```powershell
git diff --cached --name-only
Select-String -Path config.toml -Pattern '\[projects\.|trust_level|[A-Za-z]:\\'
```
