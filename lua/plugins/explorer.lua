return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local default_keys = vim.deepcopy(require("snacks.picker.config.sources").explorer.win.list.keys)
      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.explorer = opts.picker.sources.explorer or {}
      opts.picker.sources.explorer.layout =
        vim.tbl_deep_extend("force", opts.picker.sources.explorer.layout or {}, { preset = "right", preview = false })
      opts.picker.sources.explorer.win = opts.picker.sources.explorer.win or {}
      opts.picker.sources.explorer.win.list = opts.picker.sources.explorer.win.list or {}
      opts.picker.sources.explorer.win.list.keys =
        vim.tbl_deep_extend("force", default_keys, opts.picker.sources.explorer.win.list.keys or {}, { t = "tab" })
    end,
  },
}
