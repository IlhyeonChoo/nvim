-- Helpers to scaffold Clang tools config files in project root

local M = {}

local function find_project_root()
  local candidates = { ".git", "compile_commands.json", ".clang-format", ".clang-tidy" }
  local cwd = vim.fn.getcwd()
  local uv = vim.loop or vim.uv
  local dir = cwd
  while dir and dir ~= "/" do
    for _, f in ipairs(candidates) do
      local p = dir .. "/" .. f
      if uv.fs_stat(p) then return dir end
    end
    local parent = dir:match("^(.*)/[^/]+/?$")
    if parent == dir then break end
    dir = parent
  end
  return cwd
end

local function write_file(path, lines)
  local fd = assert(io.open(path, "w"))
  for _, l in ipairs(lines) do fd:write(l, "\n") end
  fd:close()
end

-- Minimal, widely used ruleset. Adjust per project later.
local CLANG_TIDY_TEMPLATE = {
  "Checks: >",
  "  -*,",
  "  bugprone-*,",
  "  clang-analyzer-*,",
  "  performance-*,",
  "  portability-*,",
  "  readability-*,",
  "  modernize-*",
  "WarningsAsErrors: ''",
  "HeaderFilterRegex: '.*'",
  "AnalyzeTemporaryDtors: false",
  "FormatStyle:     none",
}

function M.clang_tidy_scaffold()
  local root = find_project_root()
  local path = root .. "/.clang-tidy"
  if (vim.loop or vim.uv).fs_stat(path) then
    vim.notify(".clang-tidy already exists at " .. path, vim.log.levels.INFO)
    return
  end
  write_file(path, CLANG_TIDY_TEMPLATE)
  vim.notify("Created .clang-tidy at " .. path, vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("ClangTidyScaffold", M.clang_tidy_scaffold, { desc = "Create a minimal .clang-tidy in project root" })

return M

