-- harpoon: 자주 사용하는 파일을 표시하고 빠르게 이동할 수 있도록 도와주는 플러그인
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()
    -- 키 매핑은 keymaps.lua에서 관리
  end
}