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
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
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
      extend_unique(opts.ensure_installed, {
        "bash",
        "dockerfile",
        "lua",
      })
    end,
  },
}
