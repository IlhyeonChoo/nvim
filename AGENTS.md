# Repository Guidelines

## Project Structure & Module Organization

This repository is a LazyVim-based Neovim configuration. `init.lua` is the entry point and loads `lua/config/lazy.lua`. Core editor settings live in `lua/config/` (`options.lua`, `keymaps.lua`, `autocmds.lua`), while plugin specs and overrides live in `lua/plugins/`. Snippets are stored under `snippets/`. `practice/` is a self-contained workspace for testing language-server, DAP, and editing workflows; it is not part of the active Neovim runtime. `nvim.bak/` is archival backup material and should not be edited unless explicitly restoring older behavior.

## Build, Test, and Development Commands

- `nvim --headless "+qa"`: load the config in headless mode and fail fast on startup errors.
- `stylua --check .`: verify Lua formatting against `stylua.toml`.
- `stylua lua init.lua`: format active Lua configuration files.
- `cd practice/python && uv run python -m unittest discover -s tests`: run the Python practice tests.
- `cd practice/cpp && cmake -S . -B build && cmake --build build`: configure and build the C++ practice target.

Run `:Lazy sync` inside Neovim after changing plugin specs or when `lazy-lock.json` needs refresh.

## Coding Style & Naming Conventions

Write Lua with two-space indentation, spaces only, and a 120-column target as defined in `stylua.toml`. Keep plugin files focused by domain, for example `lua/plugins/git.lua` for Git integrations and `lua/plugins/completion.lua` for completion-related specs. Prefer clear module tables and Lazy.nvim spec conventions over ad hoc setup code. Code comments and developer documentation should be in English.

## Testing Guidelines

For Neovim config changes, at minimum run the headless startup check. When touching plugin specs, also open Neovim and verify the relevant `:Lazy` state or feature manually. For `practice/python`, add or update `tests/test_*.py` unittest cases. For `practice/cpp`, keep C++20 compatibility and rebuild with CMake.

## Commit & Pull Request Guidelines

This checkout does not include local Git history, so use concise imperative commit messages such as `Add clangd plugin override` or `Refine markdown keymaps`. Pull requests should describe the user-visible behavior change, list validation commands run, and note any plugin lockfile updates. Include screenshots or terminal output when UI, diagnostics, picker, or DAP behavior changes.

## Security & Configuration Tips

Do not commit machine-local secrets, tokens, or private paths. Keep generated build outputs under `practice/cpp/build/` out of reviewed changes unless they are intentionally tracked. Treat `lazy-lock.json` as the source of plugin version reproducibility.
