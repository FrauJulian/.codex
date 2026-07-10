# Context7 MCP

Enable Context7 only in a project that needs frequently changing external library documentation. Copy the example `.codex/config.toml` into that trusted project; do not enable it globally. It pins the reviewed `@upstash/context7-mcp` 2.2.5 package.

```powershell
npx -y @upstash/context7-mcp@2.2.5 --help
# Start a new Codex session in examples/context7 and inspect the MCP tool list.
```

Use Context7 only for version-dependent APIs, framework migrations, changed configuration options, or unknown/contradictory external library usage. Check source code, lockfiles, compiler errors, installed type declarations, and repository documentation first. Do not call it for language syntax, local behavior, or stable facts already available locally.

For a bounded TypeScript check:

1. Read the installed `typescript` version from the lockfile or compiler.
2. Call `resolve-library-id` with library `TypeScript` and the exact question, such as "Does TypeScript 5.8 support `--erasableSyntaxOnly`, and what is its scope?"
3. Call `query-docs` once with the selected library ID, version `5.8`, and only that compiler-option topic.
4. Record `Context7 library ID`, requested version, source URL/title, and retrieval date in the answer or work log. Verify the result against the compiler before changing code.

Do not send proprietary source, credentials, customer data, complete error dumps, or unrelated project context: queries leave the machine for Context7's service. Results may come from third-party projects and are not authoritative by themselves. Review the pinned package and upstream release before updating, prefer exact library IDs, request one narrow section, and stop after the answer is corroborated. If provenance or version is missing, cite the original library documentation instead or report the uncertainty.

Source and tool contract: [Upstash Context7](https://github.com/upstash/context7). The MCP tools are `resolve-library-id` and `query-docs`; both send the supplied free-text query to the external service.
