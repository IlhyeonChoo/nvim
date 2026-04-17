-- nvim-notify: ensure stable background and early setup
return {
  "rcarriga/nvim-notify",
  lazy = false,           -- load early so first notifications are safe
  priority = 1000,        -- before other UI plugins
  opts = {
    -- Explicit background used for 100% transparency calculation
    background_colour = "#000000",
  },
  init = function()
    -- Ensure the fallback highlight group has a background even on transparent themes
    vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#000000" })
  end,
  config = function(_, opts)
    local ok, notify = pcall(require, "notify")
    if not ok then return end
    notify.setup(opts)
    -- Route vim.notify through nvim-notify explicitly
    vim.notify = notify
  end,
}
