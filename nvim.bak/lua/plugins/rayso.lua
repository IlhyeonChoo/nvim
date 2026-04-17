-- rayso: 코드 스크린샷을 예쁘게 찍어주는 플러그인
return {
  'TobinPalmer/rayso.nvim',
  cmd = { 'Rayso' },
  config = function()
    require('rayso').setup {
      options = {
        padding = 0,
        background = false,
        theme = "candy",
      },
    }
  end,
  lazy = false,
}