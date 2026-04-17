-- Markdown 전용 옵션과 단축키
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.conceallevel = 2
vim.opt_local.spell = true

local keymap_opts = { buffer = true, silent = true }

-- 인라인 렌더링 토글(render-markdown.nvim)
vim.keymap.set(
  "n",
  "<leader>mr",
  "<cmd>RenderMarkdown toggle<CR>",
  vim.tbl_extend("force", keymap_opts, { desc = "Markdown: 인라인 렌더 토글" })
)

-- 실시간 프리뷰 토글(브라우저)
vim.keymap.set(
  "n",
  "<leader>mp",
  "<cmd>MarkdownPreviewToggle<CR>",
  vim.tbl_extend("force", keymap_opts, { desc = "Markdown: 프리뷰 토글" })
)

-- 표 모드 토글 (자동 정렬/탭 이동)
vim.keymap.set(
  "n",
  "<leader>mt",
  "<cmd>TableModeToggle<CR>",
  vim.tbl_extend("force", keymap_opts, { desc = "Markdown: TableMode 토글" })
)

-- 클립보드 이미지 삽입 빠른 실행
vim.keymap.set(
  "n",
  "<leader>mi",
  "<cmd>Pastify<CR>",
  vim.tbl_extend("force", keymap_opts, { desc = "Markdown: Pastify 이미지 붙여넣기" })
)
