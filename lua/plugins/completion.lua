return {
  {
    "kawre/neotab.nvim",
    event = "InsertEnter",
    opts = {
      tabkey = "",
      reverse_key = "",
      act_as_tab = true,
      completion = false,
      pairs = {
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
        { open = "'", close = "'" },
        { open = '"', close = '"' },
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-cmdline",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local neotab = require("neotab")
      opts.mapping = opts.mapping or {}

      local function snippet_forward()
        if vim.snippet.active({ direction = 1 }) then
          vim.schedule(function()
            vim.snippet.jump(1)
          end)
          return true
        end
        return false
      end

      local function snippet_backward()
        if vim.snippet.active({ direction = -1 }) then
          vim.schedule(function()
            vim.snippet.jump(-1)
          end)
          return true
        end
        return false
      end

      opts.mapping["<tab>"] = cmp.mapping(function()
        LazyVim.cmp.confirm({ select = true })(function()
          if snippet_forward() then
            return
          end
          neotab.tabout()
        end)
      end, { "i", "s" })

      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          return
        end
        if snippet_backward() then
          return
        end
        neotab.tabreverse()
      end, { "i", "s" })

      opts.mapping["<CR>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.abort()
        end
        fallback()
      end, { "i", "s" })
    end,
    config = function(_, opts)
      LazyVim.cmp.setup(opts)

      local cmp = require("cmp")
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = {
          disallow_symbol_nonprefix_matching = false,
        },
      })
    end,
  },
}
