-- CSS / SCSS / LESS
return {
  filetypes = { "css", "scss", "less" },
  on_attach = function(client)
    -- 포맷은 Prettier로 맡기기 위해 LSP 포맷 비활성화
    client.server_capabilities.documentFormattingProvider = false
  end,
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}
