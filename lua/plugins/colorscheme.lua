return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavor = "mocha",
      transparent_background = true,
      float = {
        transparent = true,
      },
      custom_highlights = function(colors)
        return {
          CmpDoc = { bg = colors.mantle, fg = colors.text },
          CmpDocBorder = { bg = colors.mantle, fg = colors.surface2 },
        }
      end,
    },
  },
}
