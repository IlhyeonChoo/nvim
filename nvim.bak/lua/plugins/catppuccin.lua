-- catppuccin: 부드러운 파스텔 색상을 제공하는 인기 테마
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        lualine = {},
        noice = true,
        notify = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
