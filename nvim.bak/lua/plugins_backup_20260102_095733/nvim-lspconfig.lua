-- nvim-lspconfig: Neovim의 내장 LSP 클라이언트를 설정하는 플러그인
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require("lsp.common").capabilities
    local on_attach = require("lsp.common").on_attach

    local servers = require("mason-lspconfig").get_installed_servers()
    local function configure(name, overrides)
      local base = { on_attach = on_attach, capabilities = capabilities }
      local opts = vim.tbl_deep_extend("force", base, overrides or {})
      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end

    -- lsp.servers.<name> 모듈이 있으면 그 옵션을 병합해서 사용
    local function get_custom_opts(server)
      local ok, mod = pcall(require, "lsp.servers." .. server)
      if not ok then
        return {}
      end
      if type(mod) == "function" then
        return mod() or {}
      end
      return mod or {}
    end

    -- ccls 바이너리가 있으면 ccls를 선호하고 clangd는 스킵
    local prefer_ccls = (vim.fn.executable("ccls") == 1)

    -- mason이 설치한 서버 목록에서 prefer_ccls일 때 clangd는 제외
    if prefer_ccls then
      local filtered = {}
      for _, s in ipairs(servers) do
        if s ~= "clangd" then table.insert(filtered, s) end
      end
      servers = filtered
    end

    for _, server_name in ipairs(servers) do
      -- jdtls(Java)는 전용 플러그인(nvim-jdtls)으로 ftplugin에서 구동하므로 여기선 스킵
      if server_name ~= "jdtls" then
        local custom = get_custom_opts(server_name)
        configure(server_name, custom)
      end
    end

    -- 시스템에 ccls가 있으면 mason 설치 여부와 관계없이 최종적으로 ccls를 설정
    if prefer_ccls then
      configure("ccls", get_custom_opts("ccls"))
      vim.lsp.enable("clangd", false)
    end
  end,
}
