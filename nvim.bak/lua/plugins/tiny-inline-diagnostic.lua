return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "ghost",

      options = {
        add_messages = {
          messages = true,
          display_count = false,
        },

        multilines = {
          enabled = true,
          always_show = true,
        },

        show_related = {
          enabled = true,
          max_count = 3,
        },

        virt_texts = {
          priority = 5000,
        },
      },
    })
    vim.diagnostic.config({ virtual_text = false })
  end,
}
