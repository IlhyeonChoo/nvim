-- gitsigns: git 변경 사항을 시각적으로 표시해주는 플러그인
return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- 잠재 충돌 키 제거(있을 경우만)
        pcall(vim.keymap.del, 'n', 'gb', { buffer = bufnr }) -- Comment.nvim과 충돌
        pcall(vim.keymap.del, 'n', 'gr', { buffer = bufnr }) -- LSP references와 충돌

        -- 탐색
        map('n', ']h', gs.next_hunk, 'Git: Next hunk')
        map('n', '[h', gs.prev_hunk, 'Git: Prev hunk')

        -- 액션(Leader 기반으로 일원화)
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', 'Git: Stage hunk')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', 'Git: Reset hunk')
        map('n', '<leader>hS', gs.stage_buffer, 'Git: Stage buffer')
        map('n', '<leader>hu', gs.undo_stage_hunk, 'Git: Undo stage hunk')
        map('n', '<leader>hp', gs.preview_hunk, 'Git: Preview hunk')
        map('n', '<leader>hb', gs.toggle_current_line_blame, 'Git: Toggle blame')
        map('n', '<leader>hd', gs.diffthis, 'Git: Diff this')
        map('n', '<leader>hD', function() gs.diffthis('~') end, 'Git: Diff this ~')
      end,
    })
  end,
}
