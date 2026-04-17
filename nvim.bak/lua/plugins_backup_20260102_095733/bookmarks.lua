-- bookmarks: 코드에 북마크를 추가하고 관리하는 플러그인
return {
  'tomasky/bookmarks.nvim',
  -- after = "telescope.nvim",
  event = "VimEnter",
  config = function()
    require('bookmarks').setup {
      -- sign_priority = 8,  --set bookmark sign priority to cover other sign
      save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
      keywords =  {
        ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
        ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
        ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
        ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
      },
      -- 키 매핑은 keymaps.lua에서 관리
      on_attach = function(bufnr)
        -- 키 매핑이 필요할 경우 여기에 추가
      end
    }
  end
}