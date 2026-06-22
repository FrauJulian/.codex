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
- Marketplace `webwright` from `https://github.com/microsoft/Webwright.git`
- Enabled plugin `ponytail@ponytail`
- Enabled plugin `webwright@webwright`

## What is not shared

This repository intentionally excludes credentials, local runtime state, caches, logs, sessions, sandbox data, generated plugin caches, SQLite databases, and machine identity files.

Never commit:

- `auth.json`
- `cap_sid`
- `installation_id`
- machine-specific trusted project entries in `config.toml`
- `history.jsonl`
- `sessions/`
- `cache/`
- `plugins/` downloaded plugin cache and runtime data
- `packages/`
- `.sandbox*`
- `*.sqlite*`
- `*.log`

## Setup on another PC

Back up the existing Codex directory first, then clone or copy this repo into the Codex config directory:

```powershell
Rename-Item "$env:USERPROFILE\.codex" ".codex.backup" -ErrorAction SilentlyContinue
git clone https://github.com/FrauJulian/.codex.git "$env:USERPROFILE\.codex"
```

After the first Codex start, local files such as `auth.json`, `sessions/`, logs, caches, and plugin downloads will be recreated locally and ignored by Git.

## Updating

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
