-- neogit: Git UI inspired by Magit
return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  cmd = "Neogit",
  config = function()
    require("neogit").setup({
      disable_commit_confirmation = true,
      integrations = {
        diffview = true,
      },
    })
  end,
}
