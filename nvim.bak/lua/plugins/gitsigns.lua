-- gitsigns: git 변경 사항을 시각적으로 표시해주는 플러그인
return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({})
  end,
}
