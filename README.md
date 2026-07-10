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

Install Git and Codex, then close all Codex clients. Run from PowerShell:

```powershell
git clone https://github.com/FrauJulian/.codex.git "$env:TEMP\codex-config"
& "$env:TEMP\codex-config\scripts\install.ps1"
codex login
```

The timestamped backup keeps the previous local credentials and runtime state available for manual recovery. `codex login` creates fresh authentication data; subsequent Codex starts recreate sessions, logs, caches, and plugin downloads. These files remain ignored by Git.

## Updating from GitHub

Apply a safe fast-forward update and run the shared validation:

```powershell
& "$env:USERPROFILE\.codex\scripts\update.ps1"
```

## Publishing local changes

Commit only intentional config changes:

```powershell
git status --short
git add AGENTS.md config.toml agents skills README.md .gitignore
git commit -m "Update Codex config"
git push
```

Before committing, inspect the complete staged diff and run the shared secret and policy checks:

```powershell
git diff --cached
& .\scripts\validate.ps1 -Staged
```

The check rejects whitespace errors, credential and runtime filenames, private keys, common token formats, absolute user paths, trusted-project entries, and hook trust state. Keep test values obviously fake and add `allow-secret-scan` only to the exact fixture line that intentionally exercises a detector.

The same validator runs on every push and pull request. CI also parses `config.toml`, rejects tracked runtime data, and checks every custom skill for `SKILL.md` frontmatter. `codex doctor` is intentionally not part of CI because the runner has no reproducible authenticated Codex installation.
