-- pastify: 클립보드의 이미지를 붙여넣고 저장하는 플러그인
return {
  'TobinPalmer/pastify.nvim',
  cmd = { 'Pastify' },
  config = function()
    require('pastify').setup {
      opts = {
        -- apikey = "YOUR API KEY (https://api.imgbb.com/)", -- Needed if you want to save online.
      },
    }
  end
}