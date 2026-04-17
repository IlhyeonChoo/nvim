-- mini.indentscope: 코드 블록 범위를 곡선으로 연결해 시각화
return {
  "echasnovski/mini.indentscope",
  version = "*",
  enabled = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local indentscope = require("mini.indentscope")
    indentscope.setup({
      draw = {
        delay = 0,
        animation = indentscope.gen_animation.none(),
      },
      symbol = "│",
      options = {
        border = "both",
      },
    })

    -- Catppuccin 모카 팔레트에 어울리는 하이라이트
    vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#b4befe" })
    vim.api.nvim_set_hl(0, "MiniIndentscopeSymbolOff", { fg = "#585b70" })

    -- 특정 파일 타입에서는 끄기
    local disable_filetypes = {
      "help",
      "alpha",
      "dashboard",
      "neo-tree",
      "Trouble",
      "lazy",
      "mason",
      "notify",
      "toggleterm",
      "lazyterm",
    }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = disable_filetypes,
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
