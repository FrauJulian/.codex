# Personal Codex configuration

Portable Codex setup for my own machines.

The default reasoning effort is `medium`: normal implementation, automatic review, debugging, and architecture work should favor reliable analysis over minimum latency. For a deliberately quick, low-risk task, override the reasoning effort for that invocation through the Codex UI or CLI supported by the installed version; no undocumented profile keys are stored here. Higher effort increases latency and token use, so reserve it for security reviews or unusually complex decisions.

The base configuration uses the regular `default` service tier. Fast Mode is opt-in for simple or latency-sensitive work with `codex -p fast`; the CLI layers `fast.config.toml` over the base config. Reviews, security work, architecture, and complex refactoring should stay on the default tier. Use `codex -c service_tier='"fast"'` only for a one-off override.

## Supported environment

This repository is tested with Codex CLI 0.144.1 or newer, Windows 11 build 26200, Git for Windows, and Windows PowerShell 5.1. PowerShell 7 is optional. On machines whose execution policy blocks `.ps1` files, use `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate.ps1` or an approved organization policy.

This is a public repository. Never commit credentials, sessions, machine identifiers, local trust state, private paths, or generated runtime data.

## What is shared

- `AGENTS.md` - global behavior instructions
- `config.toml` - model, agent limits, marketplace sources, plugin enablement
- `fast.config.toml` - optional Fast Mode profile
- `agents/` - custom subagent roles
- `skills/` - custom user skills
- marketplace and plugin selections via `config.toml`

Project-specific settings do not belong in this repository. Do not commit `[projects.*]` sections, `trust_level` entries, absolute local paths, or repository-specific defaults.

Current synced marketplace/plugin config:

- Marketplace `ponytail` from `https://github.com/DietrichGebert/ponytail.git`
- Enabled plugin `ponytail@ponytail`

`last_revision` records the marketplace revision seen by Codex. It is useful for review and rollback, but is not treated as an immutable plugin pin because the current CLI does not document commit-addressed installation for marketplace plugins.

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

This command never updates plugins. Review and apply a plugin update separately:

```powershell
& "$env:USERPROFILE\.codex\scripts\update-plugin.ps1" -WhatIf
& "$env:USERPROFILE\.codex\scripts\update-plugin.ps1"
```

The script displays the recorded and upstream revisions before Codex changes anything. Inspect the upstream diff between those commits, especially hooks, MCP configuration, scripts, and dependencies. Commit the resulting `config.toml` revision only after review. If upstream is unavailable or suspicious, keep the installed revision and do not run the update. To roll back, restore the prior configuration commit and reinstall only after verifying that the marketplace still serves the reviewed revision; if it cannot, keep the cached plugin offline or disable it.

## Rollback and recovery

Before an update, note the current revision with `git rev-parse HEAD`. Roll back a bad shared update with `git log --oneline`, then `git switch --detach <known-good-commit>` to verify it; return to `master` and revert the bad commit rather than rewriting published history. If Codex cannot parse `config.toml`, validate it with `python -c "import pathlib,tomllib; tomllib.loads(pathlib.Path('config.toml').read_text())"`, compare it with `git diff`, and restore only intentional shared keys from a known-good commit.

Setup backups may contain `auth.json`, sessions, and other credentials. After recovery, delete an obsolete backup from an elevated local shell with `Remove-Item -LiteralPath '<verified-backup-path>' -Recurse -Force`; verify the resolved path first, never use a wildcard, and remember that deletion does not revoke copied tokens. Revoke exposed credentials separately.

## Troubleshooting and ownership

- `git status --short` and `git diff` diagnose shared repository changes; Git owns only tracked portable files.
- `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate.ps1` checks shared syntax and policy.
- `codex.cmd --version`, `codex.cmd plugin list`, and `codex.cmd --strict-config doctor --summary` diagnose the installed runtime. If `codex.ps1` is blocked, use `codex.cmd`.
- Authentication, sessions, caches, plugin downloads, trusted projects, and hook approvals are local runtime state. Recreate them with login/startup rather than restoring them to Git.
- A rejected fast-forward means the local branch diverged; inspect it instead of forcing an update. An unavailable plugin upstream is not a reason to replace the reviewed cached version.

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
