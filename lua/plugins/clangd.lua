return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local clangd = opts.servers and opts.servers.clangd
      if not clangd or not clangd.cmd then
        return
      end

      local cmd = {}
      for _, arg in ipairs(clangd.cmd) do
        if arg ~= "--function-arg-placeholders" then
          table.insert(cmd, arg)
        end
      end

      table.insert(cmd, "--function-arg-placeholders=1")
      table.insert(cmd, "--log=error")

      clangd.cmd = cmd
    end,
  },
}
