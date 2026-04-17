-- Go: gopls
return {
  settings = {
    gopls = {
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        shadow = true,
        nilness = true,
        unusedwrite = true,
      },
      staticcheck = true,
      gofumpt = true,
      hints = {
        parameterNames = true,
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        rangeVariableTypes = true,
      },
    },
  },
}

