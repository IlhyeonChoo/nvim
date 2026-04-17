-- mason: LSP 서버, 포맷터, 린터 등을 쉽게 설치하고 관리하는 플러그인
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        -- 기존
        "lua_ls", "clangd", "pyright", "texlab", --"ocamllsp", "pyrefly",
        "jsonls",
        -- 추가: Java / Go / C# / Web
        "jdtls",                 -- Java
        "gopls",                 -- Go
        "omnisharp",             -- C#
        "vtsls",                 -- JavaScript / TypeScript (recommended)
        "html",                  -- HTML
        "cssls",                 -- CSS
        "emmet_language_server", -- Emmet
        "eslint",                -- ESLint (JS/TS)
        "autotools_ls",          -- Makefile/Autotools
        "cmake",                 -- CMake
        -- Docker
        "dockerls",
        "docker_compose_language_service",
      },
      automatic_installation = true,
      automatic_enable = false,
    })
  end,
}
