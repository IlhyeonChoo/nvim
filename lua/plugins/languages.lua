local function extend_unique(list, items)
  local seen = {}
  for _, item in ipairs(list or {}) do
    seen[item] = true
  end
  for _, item in ipairs(items) do
    if not seen[item] then
      table.insert(list, item)
      seen[item] = true
    end
  end
end

local function remove_values(list, values)
  if type(list) ~= "table" then
    return
  end

  local remove = {}
  for _, value in ipairs(values) do
    remove[value] = true
  end

  for index = #list, 1, -1 do
    if remove[list[index]] then
      table.remove(list, index)
    end
  end
end

local function has_ocaml_project_files()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_name = vim.fs.basename(current_file)
  if
    current_file:match("%.ml[ily]?$")
    or current_file:match("%.rei?$")
    or current_file:match("%.opam$")
    or current_name == "dune"
    or current_name == "dune-project"
    or current_name == "dune-workspace"
  then
    return true
  end

  local start = current_file ~= "" and vim.fs.dirname(current_file) or vim.uv.cwd()
  if not start or start == "" then
    start = vim.fn.getcwd()
  end

  local markers = vim.fs.find(function(name)
    return name == "dune"
      or name == "dune-project"
      or name == "dune-workspace"
      or name == "esy.json"
      or name == ".merlin"
      or name == "merlin.opam"
      or name:match("%.opam$") ~= nil
  end, { path = start, upward = true, limit = 1 })

  if #markers > 0 then
    return true
  end

  local cwd = vim.uv.cwd() or vim.fn.getcwd()
  local cwd_markers = {
    "dune",
    "dune-project",
    "dune-workspace",
    ".merlin",
    "esy.json",
    "*.opam",
    "*.ml",
    "*.mli",
    "*.mll",
    "*.mly",
    "*.re",
    "*.rei",
  }

  for _, marker in ipairs(cwd_markers) do
    if #vim.fn.globpath(cwd, marker, false, true) > 0 then
      return true
    end
  end

  return false
end

return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.filetype.add({
        filename = {
          ["compose.yaml"] = "yaml.docker-compose",
          ["compose.yml"] = "yaml.docker-compose",
          ["docker-compose.yaml"] = "yaml.docker-compose",
          ["docker-compose.yml"] = "yaml.docker-compose",
        },
      })
    end,
    opts = {
      servers = {
        pyrefly = {
          enabled = false,
        },
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },
        dockerls = {
          enabled = false,
        },
        docker_compose_language_service = {
          enabled = false,
        },
        docker_language_server = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if has_ocaml_project_files() then
        return
      end

      opts.servers = opts.servers or {}
      local ocamllsp = type(opts.servers.ocamllsp) == "table" and opts.servers.ocamllsp or {}
      opts.servers.ocamllsp = vim.tbl_deep_extend("force", ocamllsp, {
        enabled = false,
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if not has_ocaml_project_files() then
        remove_values(opts.ensure_installed, {
          "ocaml-lsp",
          "ocamlformat",
          "ocamlformat-rpc",
          "ocamllsp",
        })
      end
      extend_unique(opts.ensure_installed, {
        "bash-language-server",
        "docker-compose-language-service",
        "docker-language-server",
        "dockerfile-language-server",
        "lua-language-server",
        "shellcheck",
        "shfmt",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) ~= "table" then
        return
      end
      if not has_ocaml_project_files() then
        remove_values(opts.ensure_installed, {
          "menhir",
          "ocaml",
          "ocaml_interface",
        })
      end
      extend_unique(opts.ensure_installed, {
        "bash",
        "dockerfile",
        "lua",
      })
    end,
  },
}
