# Personal Codex configuration

Portable Codex CLI configuration for my Windows machines. The repository contains shared behavior, specialized agents and skills, validation rules, and opt-in examples. Credentials and generated runtime state stay local.

## Base configuration

`config.toml` currently defines:

- model `gpt-5.6-sol` with `medium` reasoning effort
- the regular `default` service tier
- automatic approval review
- up to six agent threads with one level of subagents
- the `ponytail` marketplace and enabled `ponytail@ponytail` plugin
- idle-sleep prevention
- the elevated Windows sandbox
- a compact TUI status line

Use the normal configuration for reviews, security work, architecture, debugging, and complex refactoring. For a quick, low-risk task, `codex -p fast` layers `fast.config.toml` over the base configuration and selects the `fast` service tier. For one invocation only, use:

```powershell
codex -c service_tier='"fast"'
```

The default reasoning effort remains `medium`. Override it through an option supported by the installed Codex version rather than adding undocumented profile keys.

## Supported environment

The repository is tested with:

- Codex CLI 0.144.1 or newer
- Windows 11 build 26200
- Git for Windows
- Windows PowerShell 5.1; PowerShell 7 is optional
- Python 3.11 or newer for `tomllib` validation

Check the installed tools with:

```powershell
codex.cmd --version
git --version
python --version
```

For bounded repository searches, install [ripgrep](https://github.com/BurntSushi/ripgrep) and [fd](https://github.com/sharkdp/fd):

```powershell
winget install BurntSushi.ripgrep.MSVC
winget install sharkdp.fd
rg --version
fd --version
```

Codex should use `rg --files` or `fd` before broad directory reads and bound content searches by path, glob, and `--max-count`. If these tools are unavailable, use `Get-ChildItem -Recurse -File` and `Select-String` with equivalent limits.

## Repository contents

### Shared configuration

- `AGENTS.md` contains the global implementation, search, testing, dependency, and subagent rules.
- `config.toml` contains portable Codex settings, marketplace metadata, and plugin enablement.
- `fast.config.toml` is the opt-in Fast Mode overlay selected with `codex -p fast`.
- `.gitignore` allow-lists portable repository files and excludes generated Codex state.
- `LICENSE` contains the repository license.

### Agents

The `agents/` directory contains focused custom roles. Read-only roles cannot modify the workspace.

| Agent | Access | Purpose |
| --- | --- | --- |
| `architect_planner` | read-only | Architecture, APIs, data models, migrations, risks, and delivery planning |
| `code_reviewer` | read-only | Correctness, regressions, maintainability, contracts, failure handling, and tests |
| `git_blame` | read-only | Repository history and the origin of behavior |
| `performance_security_reviewer` | read-only | Exploitable security defects and measurable performance or resource risks |
| `security_specialist` | read-only | Threat modeling, authentication, authorization, injection, secrets, cryptography, and supply-chain risks |
| `csharp_implementer` | workspace-write | Modern C# and .NET implementation |
| `frontend_implementer` | workspace-write | WPF, XAML, HTML, CSS, accessibility, and responsive UI implementation |
| `sql_expert` | workspace-write | SQL Server and MariaDB schemas, queries, migrations, indexes, and plans |
| `typescript_implementer` | workspace-write | Strict modern TypeScript implementation |

### Skills

The `skills/` directory contains reusable task instructions:

- `clean-text-writer` for concise German and English technical writing
- `csharp-modern` for current C#/.NET implementation and review
- `frontend-modern` for WPF/XAML, HTML, and CSS
- `latex-document` for professional LaTeX documents
- `repository-research` for bounded C# and TypeScript repository discovery
- `reviewer-performance-security-readability` for evidence-based reviews
- `sql-modern` for SQL Server and MariaDB
- `style-ui-ux` for application UI/UX and accessibility
- `typescript-modern` for strict TypeScript

Some skills also contain `agents/openai.yaml` presentation metadata.

### Scripts

- `scripts/install.ps1` backs up an existing target directory, clones this repository to `~/.codex`, validates it, and prints the fresh-login next step.
- `scripts/update.ps1` requires a clean working tree, performs `git pull --ff-only`, and runs validation. It does not update plugins.
- `scripts/update-plugin.ps1` compares the recorded Ponytail revision with upstream and, after confirmation, asks Codex to update the plugin. `-WhatIf` only displays the proposed action.
- `scripts/validate.ps1` parses `config.toml`, rejects tracked runtime files and non-portable settings, checks custom skill frontmatter, and optionally scans staged changes for secrets and policy violations.

### Tool guides and examples

- `docs/ast-grep.md` documents structural TypeScript search and interactive rewrites. C# remains on Roslyn tools unless the installed ast-grep version explicitly supports it.
- `docs/context7-mcp.md` documents the opt-in Context7 MCP server and its privacy and provenance limits.
- `examples/context7/.codex/config.toml` pins `@upstash/context7-mcp` 2.2.5 for project-local use.
- `docs/playwright-mcp.md` documents bounded, headless browser diagnosis.
- `examples/playwright/.codex/config.toml` pins `@playwright/mcp` 0.0.75 and allows only `http://127.0.0.1:4173`.
- `examples/playwright/index.html` is the local browser smoke-test page.
- `docs/semgrep.md` documents local Semgrep installation, scanning, suppression, and troubleshooting.

Do not copy the example MCP servers into the global configuration. Enable them only in a trusted project that needs them.

### Security checks and CI

`semgrep.yml` contains three error-level rules:

- TypeScript SQL template interpolation
- C# `BinaryFormatter` deserialization
- logging likely secrets from TypeScript

`tests/semgrep/` contains intentionally unsafe fixtures for all three rules. `.github/workflows/semgrep.yml` validates the rules, verifies the expected fixture findings, and scans the repository on every push and pull request.

`.github/workflows/validate.yml` runs `scripts/validate.ps1` on every push and pull request. CI parses the shared configuration, rejects tracked runtime data, and checks every custom skill for valid `SKILL.md` frontmatter. `codex doctor` is not part of CI because the runner has no reproducible authenticated Codex installation.

## Shared and local state

This is a public repository. Never commit credentials, sessions, machine identifiers, private paths, or generated runtime data.

Codex may append machine-specific sections directly to the tracked `config.toml`, including:

- `[projects.*]` and `trust_level` <!-- allow-secret-scan -->
- `[hooks.state]` and trusted hook hashes <!-- allow-secret-scan -->
- TUI onboarding state such as `[tui.model_availability_nux]`

These local edits are expected after using Codex, but they must remain uncommitted. Git cannot ignore individual TOML sections, so `config.toml` may appear modified locally even when the checked-in configuration is portable. Inspect `git diff -- config.toml` before updating or committing.

The repository also excludes:

- `auth.json`, `cap_sid`, and `installation_id`
- `history.jsonl`, `sessions/`, logs, and SQLite databases
- caches, packages, downloaded plugins, and sandbox data
- private keys and other generated runtime files

## Setup on another PC

Install Git, Codex, and Python, then close all Codex clients. Run from PowerShell:

```powershell
git clone https://github.com/FrauJulian/.codex.git "$env:TEMP\codex-config"
& "$env:TEMP\codex-config\scripts\install.ps1"
codex login
```

The installer moves an existing `~/.codex` directory to a timestamped backup before cloning. That backup may contain credentials and sessions. Keep it only until recovery is complete. `codex login` creates fresh authentication data; subsequent Codex starts recreate runtime directories and plugin downloads.

If execution policy blocks scripts, invoke the installer through a temporary bypass:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '$env:TEMP\codex-config\scripts\install.ps1'"
```

## Updating from GitHub

`update.ps1` deliberately refuses to run with any local changes. If `config.toml` contains only Codex-generated local trust state, preserve it in a stash, update, and restore it:

```powershell
Set-Location "$env:USERPROFILE\.codex"
git diff -- config.toml
git stash push -m "Local Codex state" -- config.toml
& .\scripts\update.ps1 -RepositoryRoot "$env:USERPROFILE\.codex"
git stash pop
```

Do not stash blindly when the working tree contains intentional repository work. Commit or handle those changes separately. If `git stash pop` conflicts because upstream changed `config.toml`, preserve the new shared settings and re-add only the required local trust sections.

With a restrictive execution policy, use:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$env:USERPROFILE\.codex\scripts\update.ps1" -RepositoryRoot "$env:USERPROFILE\.codex"
```

A rejected fast-forward means the local branch diverged. Inspect it instead of forcing an update.

## Updating Ponytail

Repository updates never update plugins. Compare the recorded and upstream revisions first:

```powershell
& "$env:USERPROFILE\.codex\scripts\update-plugin.ps1" -WhatIf
& "$env:USERPROFILE\.codex\scripts\update-plugin.ps1"
```

Inspect the upstream diff between the displayed commits, especially hooks, MCP configuration, scripts, and dependencies. Commit a changed `last_revision` only after review. `last_revision` records what Codex saw; it is not an immutable plugin pin because the current CLI does not document commit-addressed marketplace installation.

If upstream is unavailable or suspicious, keep the installed revision. To roll back, restore the prior configuration commit and reinstall only after verifying that the marketplace still serves the reviewed revision. Otherwise keep the cached plugin offline or disable it.

## Validation

Validate the working tree from the repository root:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate.ps1 -RepositoryRoot "$PWD"
```

This intentionally fails if the working `config.toml` contains local trust state. To validate exactly what will be committed, stage only portable changes and use:

```powershell
git diff --cached
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate.ps1 -RepositoryRoot "$PWD" -Staged
```

The staged check rejects whitespace errors, credential and runtime filenames, private keys, common token formats, absolute user paths, trusted-project entries, and hook trust state. Keep security-rule fixtures obviously fake and add `allow-secret-scan` only to the exact fixture line that intentionally exercises a detector.

Optional diagnostics:

```powershell
codex.cmd plugin list
codex.cmd --strict-config doctor --summary
```

`doctor` may report local authentication or network failures; those results are separate from repository validation.

## Publishing changes

Inspect all changes and stage files intentionally. Use patch staging for `config.toml` so generated local sections are not included:

```powershell
git status --short
git diff
git add -p config.toml
git add README.md # Add each other intentionally changed path explicitly.
git diff --cached
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate.ps1 -RepositoryRoot "$PWD" -Staged
git commit -m "Update Codex config"
git push
```

Stage only paths that were intentionally changed. Never use `git add -A` while `config.toml` contains generated local state.

## Rollback and recovery

Before updating, record the current revision with `git rev-parse HEAD`. To investigate a bad shared update, use `git log --oneline` and `git switch --detach <known-good-commit>`. Return to `master` and revert the bad commit instead of rewriting published history.

If Codex cannot parse the configuration, compare `config.toml` with `git diff` and validate TOML directly:

```powershell
python -c "import pathlib,tomllib; tomllib.loads(pathlib.Path('config.toml').read_text(encoding='utf-8'))"
```

Restore only intentional shared keys from a known-good commit. Setup backups may contain credentials. After recovery, verify the exact backup path before deleting it with `Remove-Item -LiteralPath '<verified-backup-path>' -Recurse -Force`. Deleting a file does not revoke copied tokens; revoke exposed credentials separately.
