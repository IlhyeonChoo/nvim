-- iwe: 마크다운 기반 지식관리(LSP/CLI) 플러그인
return {
  "iwe-org/iwe.nvim",
  ft = { "markdown" },
  cmd = { "IWE" },
  dependencies = {
    "ibhagwan/fzf-lua",
  },
  opts = {
    lsp = {
      cmd = { "iwes" },
    },
    picker = {
      backend = "fzf_lua",
      fallback_notify = true,
    },
  },
  config = function(_, opts)
    require("iwe").setup(opts)
  end,
}
