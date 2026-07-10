---
name: repository-research
description: Find the smallest relevant set of files, symbols, and callers in C#, TypeScript, or mixed repositories. Use before broad codebase reading, when locating an implementation, tracing a bug, or estimating change scope.
---

# Repository research

1. List candidates with `rg --files` and narrow them with paths and globs. Use `fd` when available for filename, extension, or directory queries.
2. Search exact symbols or error text with `rg -n --max-count 50`. Add `-g` filters and exclude generated, dependency, build, and cache directories.
3. Read only matching files and the nearest configuration or tests. Trace every caller before changing shared behavior.
4. Use PowerShell `Get-ChildItem` and `Select-String` only when `rg` or `fd` is unavailable.
5. Stop expanding the search once the actual flow and validation point are known.

```powershell
rg --files -g '*.cs' -g '*.ts' -g '!node_modules/**' -g '!bin/**' -g '!obj/**'
fd --extension cs --extension ts src
rg -n --max-count 50 'ProcessOrder|processOrder' src tests
```
