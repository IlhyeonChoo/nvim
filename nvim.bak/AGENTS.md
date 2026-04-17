# Repository Guidelines

## Project Structure & Module Organization
`init.lua` is the entry point: it bootstraps `lazy.nvim`, then loads `lua/options.lua`, `lua/keymaps.lua`, `lua/filetypes.lua`, and `lua/lsp/clang_helpers.lua`. Keep plugin specs in `lua/plugins/` with one file per plugin, and keep shared LSP behavior in `lua/lsp/common.lua` with server-specific overrides in `lua/lsp/servers/<server>.lua`. Filetype-specific tweaks belong in `ftplugin/`, and reusable snippets live in `snippets/`.

Avoid editing backup material unless the task explicitly targets it: `lua/plugins_backup_20260102_095733/`, `*.bak`, and `*.backup`.

## Build, Test, and Development Commands
Use Neovim itself as the main development entrypoint:

- `nvim` loads the full config for manual verification.
- `nvim --headless "+Lazy! sync" +qa` installs or updates plugins from the current specs.
- `luac -p init.lua` checks startup syntax.
- `luac -p lua/plugins/<name>.lua` validates a new or edited plugin spec.
- `nvim --headless "+checkhealth" +qa` runs a broad health check; use targeted checks such as `nvim --headless "+checkhealth iwe" +qa` when touching a specific integration.
- `rg -n "<keyword>" lua init.lua` is the preferred way to trace existing settings before changing them.

## Coding Style & Naming Conventions
Match the existing Lua style: 2-space indentation, readable table layouts, and small focused modules. Plugin files should return a single Lazy spec via `return { ... }`. Keep global keymaps in `lua/keymaps.lua`; keep plugin entry mappings inside the plugin spec’s `keys` field. Name new files after the plugin or server they configure, for example `lua/plugins/oil.lua` or `lua/lsp/servers/pyright.lua`.

## Testing Guidelines
There is no formal automated test suite in this repo. Before opening a PR, syntax-check every touched Lua file with `luac -p` and do at least one headless Neovim startup. If you change plugin loading, LSP wiring, or formatter behavior, verify the relevant workflow manually inside `nvim`.

## Commit & Pull Request Guidelines
Recent history favors short, direct commit subjects without prefixes, for example `stop hardtime` and `disable obsidian when vault does not exist`. Keep commits focused and describe one behavior change per commit. PRs should include: what changed, why it changed, how it was verified, and screenshots or short clips for UI-visible behavior. Call out intentional `lazy-lock.json` updates and avoid committing local-only paths or vault-specific configuration by accident.
