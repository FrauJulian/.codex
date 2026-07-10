# Semgrep

Install Semgrep outside the repository and run the same rules as CI:

```powershell
pipx install semgrep
semgrep scan --validate --config semgrep.yml
semgrep scan --no-git-ignore --config semgrep.yml --severity ERROR --error --max-lines-per-finding 20 --exclude tests/semgrep .
```

The rules reject TypeScript SQL template interpolation, C# `BinaryFormatter` deserialization, and logging likely secret variables. The files under `tests/semgrep` intentionally trigger all rules; scan them with `--no-git-ignore` because this repository ignores everything by default, and expect exit code 1. Production code should produce no findings.

Fix the code first. If a finding is demonstrably safe, suppress only that line with `# nosemgrep: rule-id` (or the language's comment syntax) and state the reason in the same comment. Never use a broad path exclusion for one false positive. Keep findings bounded with `--severity ERROR` and `--max-lines-per-finding` before passing output to Codex.

If validation fails, run the single rule with `semgrep scan --config semgrep.yml --include '<file>' --verbose`, confirm the parsed language, and reduce the fixture to the smallest reproducer. Update the rule and its fixture together.
