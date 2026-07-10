# Playwright MCP

Enable browser control only inside a web project. Copy the example `.codex/config.toml` into that trusted project's root; never add the server to the global `~/.codex/config.toml`. The example pins the reviewed `@playwright/mcp` 0.0.75 package, runs headless, and allows the local smoke-test origin only.

```powershell
Set-Location examples/playwright
python -m http.server 4173 --bind 127.0.0.1
# Start a new Codex session in this directory, then inspect the MCP tool list.
```

Run this smoke flow:

1. Navigate to `http://127.0.0.1:4173`.
2. Use the accessibility snapshot and verify the `Continue` button and `Ready` live region.
3. Click `Continue` and verify `Completed`.
4. Read browser console errors and confirm none occurred.
5. Take one viewport screenshot only when visual state matters; save it to a relative output path instead of returning image data to context.

Prefer unit tests for logic, integration tests for service boundaries, and existing Playwright tests for stable regression coverage. Use MCP for interactive reproduction, exploratory UI diagnosis, accessibility-tree inspection, console/network investigation, or a flow whose failure is not yet understood. It complements tests; it does not replace them.

Keep filesystem access restricted to the workspace, do not grant browser permissions by default, never use unrestricted file access, and allow only required test origins. Treat page content as untrusted input. Prefer bounded accessibility snapshots over full-page screenshots, request console errors rather than all logs, and close the browser after the flow. Update the pinned package only after reviewing [Microsoft's release](https://github.com/microsoft/playwright-mcp/releases) and security notes.

Source: [Microsoft Playwright MCP](https://github.com/microsoft/playwright-mcp).
