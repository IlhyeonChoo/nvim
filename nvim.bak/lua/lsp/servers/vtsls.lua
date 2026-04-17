-- TypeScript/JavaScript: vtsls (recommended over tsserver)
return {
  -- 포맷은 Prettier에 맡기기 위해 LSP 포맷 비활성화
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
      preferences = {
        includeCompletionsForModuleExports = true,
        includeCompletionsWithInsertTextCompletions = true,
        importModuleSpecifierPreference = "non-relative",
        quotePreference = "single",
      },
      suggest = { completeFunctionCalls = true },
      format = { enable = false },
    },
    javascript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
      preferences = {
        includeCompletionsForModuleExports = true,
        includeCompletionsWithInsertTextCompletions = true,
        importModuleSpecifierPreference = "non-relative",
        quotePreference = "single",
      },
      suggest = { completeFunctionCalls = true },
      format = { enable = false },
    },
    vtsls = {
      tsserver = {
        globalPlugins = {},
      },
    },
  },
}
