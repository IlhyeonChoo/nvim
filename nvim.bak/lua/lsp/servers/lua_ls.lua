-- 서버별 옵션 모듈 예시: lsp.servers.lua_ls
-- nvim-lspconfig.lua에서 기본 on_attach/capabilities와 병합됩니다.

return {
  on_init = function(client)
    local path = client.workspace_folders and client.workspace_folders[1] and client.workspace_folders[1].name or nil
    if path and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc")) then
      return
    end
    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    })
  end,
  settings = { Lua = {} },
}

