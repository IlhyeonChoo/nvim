-- fzf-lua: fzf를 이용한 초고속 퍼지 파인더
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        preview = {
          default = "bat", -- bat이 설치되어 있다면 사용
          layout = "flex", -- 창 크기에 따라 레이아웃 자동 조정
        },
      },
      files = {
        -- gitignore 등을 존중
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
      },
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --e",
      },
    })
  end
}
