# ast-grep

Install the CLI on Windows without adding a repository dependency:

```powershell
npm install --global @ast-grep/cli
ast-grep --version
```

Use `rg` for text and filenames. Use ast-grep when formatting or nesting makes text matching unreliable. First list matches, then apply a rewrite interactively:

```powershell
ast-grep run --pattern '$OBJ.oldMethod($ARGS)' --lang ts src
ast-grep run --pattern '$OBJ.oldMethod($ARGS)' --rewrite '$OBJ.newMethod($ARGS)' --interactive --lang ts src
git diff
npm test
```

For repeatable rules, run a single rule as a dry check before any fix:

```powershell
ast-grep scan --rule rules/no-old-method.yml src
ast-grep scan --rule rules/no-old-method.yml --interactive src
```

The current built-in language list includes TypeScript but not C#. Do not parse C# as another language. For C#, prefer Roslyn analyzers/refactorings and the compiler; use ast-grep only after the installed version explicitly reports C# support with `ast-grep --help` and a representative query succeeds. Always inspect the match list or interactive diff and run the repository's existing build, analyzers, and narrow tests afterward.

References: [official quick start](https://ast-grep.github.io/guide/quick-start.html), [CLI language list](https://ast-grep.github.io/reference/languages.html).
