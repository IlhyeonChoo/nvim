-- barbar: 버퍼(열린 파일) 목록을 탭 형태로 보여주는 플러그인
return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  opts = {},
  lazy = false,
  init = function() vim.g.barbar_auto_setup = false end,
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
