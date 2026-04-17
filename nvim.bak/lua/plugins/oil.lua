-- oil: 버퍼 기반 파일 탐색/수정 플러그인
return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Oil",
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
  },
}
