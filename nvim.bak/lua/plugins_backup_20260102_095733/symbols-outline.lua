-- symbols-outline: 코드의 심볼(함수, 변수 등)을 아웃라인으로 보여주는 플러그인
return {
  "simrat39/symbols-outline.nvim",
  cmd = "SymbolsOutline",
  keys = {
    { "<leader>o", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
  },
  config = function()
    require("symbols-outline").setup()
  end,
}