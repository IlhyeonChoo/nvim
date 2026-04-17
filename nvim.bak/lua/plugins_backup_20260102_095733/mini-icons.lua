-- mini.icons: 범용 아이콘 제공 (folke/lazy, which-key 등에서 권장)
return {
  'echasnovski/mini.icons',
  version = false,
  config = function()
    require('mini.icons').setup()
  end,
}

