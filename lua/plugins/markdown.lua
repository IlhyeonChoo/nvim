return {
  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown", "rmd" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      filetypes = {
        markdown = true,
        rmd = true,
      },
      mappings = {
        MkdnFoldSection = { "n", "<leader>mf" },
        MkdnUnfoldSection = { "n", "<leader>mF" },
      },
    },
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown", "text" },
    init = function()
      vim.g.table_mode_corner = "|"
      vim.g.table_mode_disable_mappings = 1
    end,
  },
}
