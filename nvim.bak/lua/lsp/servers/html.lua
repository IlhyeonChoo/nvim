-- HTML
return {
  filetypes = { "html" },
  on_attach = function(client)
    -- 포맷은 Prettier로 맡기기 위해 LSP 포맷 비활성화
    client.server_capabilities.documentFormattingProvider = false
  end,
  settings = {
    html = {
      format = { wrapLineLength = 120, unformatted = "pre,code,textarea" },
      hover = { documentation = true, references = true },
    },
  },
}
