-- conform: 코드 포맷팅 플러그인
return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      -- JS/TS: ESLint로 우선 fix 후 Prettier로 포맷
      javascript = { "eslint_d", { "prettierd", "prettier" } },
      typescript = { "eslint_d", { "prettierd", "prettier" } },
      javascriptreact = { "eslint_d", { "prettierd", "prettier" } },
      typescriptreact = { "eslint_d", { "prettierd", "prettier" } },
      html = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      json = { { "prettierd", "prettier" } },
      go = { { "goimports", "gofumpt", "gofmt" } },
      -- java: google-java-format는 2스페이스 고정이므로 제외 (LSP fallback 사용)
      cs = { "csharpier" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      objc = { "clang_format" },
      objcpp = { "clang_format" },
      cuda = { "clang_format" },
      cmake = { "cmake_format" },
      -- 다른 언어에 대한 포맷터 추가 가능
    },
    -- 포맷터 개별 동작 커스터마이즈
    formatters = {
      eslint_d = {
        -- 프로젝트에 ESLint 설정이 있을 때만 실행
        condition = function(ctx)
          local util = require("conform.util")
          local found = util.root_file({
            -- Flat config (2023+)
            "eslint.config.js", "eslint.config.cjs", "eslint.config.mjs", "eslint.config.ts",
            -- Legacy config
            ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json",
          })(ctx)
          if found then return true end
          -- package.json 안의 eslintConfig 필드를 검사
          local pkg = util.find_package_json_ancestor(ctx.filename)
          if not pkg then return false end
          local ok, data = pcall(util.read_json_file, pkg)
          return ok and type(data) == "table" and data.eslintConfig ~= nil
        end,
      },
      -- .clang-format이 있으면 그 파일을, 없으면 Google 스타일로 포맷
      clang_format = {
        prepend_args = { "--style=file", "--fallback-style=Google" },
      },
      cmake_format = {},
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
