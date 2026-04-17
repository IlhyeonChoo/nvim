-- vim-bookmarks: 북마크 관리 플러그인 (UI 독립적, fzf와 연동 용이)
return {
  "MattesGroeger/vim-bookmarks",
  init = function()
    -- 기본 키 매핑 비활성화 (keymaps.lua에서 직접 제어하기 위함)
    vim.g.bookmark_no_default_key_mappings = 1
    
    -- 아이콘 설정
    vim.g.bookmark_sign = '🔖'
    vim.g.bookmark_annotation_sign = '📝'
    
    -- 하이라이트 설정
    vim.g.bookmark_highlight_lines = 1
    
    -- 저장 위치
    vim.g.bookmark_save_per_working_dir = 1
    vim.g.bookmark_auto_save = 1
  end
}
