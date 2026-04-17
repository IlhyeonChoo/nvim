return {
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = {
      {
        "<leader>fd",
        function()
          local dir = vim.fn.expand("%:p:h")
          if dir == "" or vim.fn.isdirectory(dir) == 0 then
            dir = vim.uv.cwd()
          end
          require("oil").open(dir)
        end,
        desc = "Oil (Buffer Dir)",
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      default_file_explorer = false,
      view_options = {
        show_hidden = true,
      },
    },
  },
}
