-- JSON / JSONC
-- 참고: Prettier로 포맷하도록 LSP 포맷은 비활성화
return function()
  local schemas = {}
  local ok, schemastore = pcall(require, "schemastore")
  if ok then
    schemas = schemastore.json.schemas()
  end
  return {
    filetypes = { "json", "jsonc" },
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
    end,
    settings = {
      json = {
        validate = { enable = true },
        schemas = schemas,
        format = { enable = false },
      },
    },
  }
end

