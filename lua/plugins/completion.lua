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
      opts.window = opts.window or {}
      opts.window.documentation = vim.tbl_deep_extend("force", opts.window.documentation or {}, {
        winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder,Search:None",
      })

      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        if col == 0 then
          return false
        end
        local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
        return text:sub(col, col):match("%s") == nil
      end

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

      opts.mapping["<Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })
          return
        end
        if snippet_forward() then
          return
        end
        if has_words_before() then
          cmp.complete()
          return
        end
        neotab.tabout()
      end, { "i", "s" })
      opts.mapping["<tab>"] = opts.mapping["<Tab>"]

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
