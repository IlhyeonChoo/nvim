-- C#: OmniSharp (Roslyn 기반)
return {
  -- OmniSharp는 Mason을 통해 설치되며 dotnet 필요
  on_attach = function(client)
    -- 포맷은 csharpier로 위임
    client.server_capabilities.documentFormattingProvider = false
  end,
  settings = {
    FormattingOptions = {
      OrganizeImports = true,
    },
    EnableEditorConfigSupport = true,
    EnableMsBuildLoadProjectsOnDemand = true,
    EnableRoslynAnalyzers = true,
    Sdk = { IncludePrereleases = false },
  },
}
