# Global Codex Instructions

- Answer in the user's language unless the repository or requested artifact requires another language.
- Preserve the existing language of documentation, comments, and user-facing text.
- Use current C# and TypeScript standards.
- Write maintainable, easy-to-read code.
- Find relevant files with `rg --files` or `fd` before broad reads; use bounded `rg` searches with paths, globs, and `--max-count`. Fall back to PowerShell search tools when unavailable.
- Use ast-grep for syntax-dependent searches and deterministic refactors; inspect matches or an interactive diff before applying rewrites, then run compiler, analyzers, and relevant tests.
- Run the narrowest relevant tests; use broader suites only when the change risk justifies them.
- Prefer existing dependencies and platform features. Add production dependencies only with explicit approval; add development-only dependencies only when justified and no reasonable built-in alternative exists.
- Use subagents only when they add clear value and stay within the configured agent depth.
- More specific repository instructions override these global defaults when they conflict.
