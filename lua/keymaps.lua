-- 키 매핑 전용 파일

--[[
  플러그인 키 매핑 모음
  - 각 플러그인별로 섹션을 나누고 설명을 추가
  - 중복된 키 매핑이 있는 경우 주의
--]]

-- ===== neo-tree =====
vim.keymap.set(
	"n",
	"<leader>fo",
	"<Cmd>Neotree toggle right<CR>",
	{ noremap = true, silent = true, desc = "Neotree: 토글(오른쪽)" }
)
vim.keymap.set(
	"n",
	"<leader>ff",
	"<Cmd>Neotree focus right<CR>",
	{ noremap = true, silent = true, desc = "Neotree: 포커스(오른쪽)" }
)

-- ===== oil =====
vim.keymap.set("n", "<leader>fd", "<cmd>Oil<cr>", { desc = "Oil: 현재 파일 디렉터리 열기" })

-- ===== symbols-outline =====
vim.keymap.set("n", "<leader>o", "<cmd>SymbolsOutline<cr>", { desc = "심볼 아웃라인 열기" })

-- ===== aerial =====
vim.keymap.set("n", "<leader>ao", "<cmd>AerialToggle<cr>", { desc = "Aerial: 아웃라인 토글" })
vim.keymap.set("n", "<leader>aj", "<cmd>AerialNext<cr>", { desc = "Aerial: 다음 심볼" })
vim.keymap.set("n", "<leader>ak", "<cmd>AerialPrev<cr>", { desc = "Aerial: 이전 심볼" })
vim.keymap.set("n", "<leader>af", function()
	local ok, aerial = pcall(require, "aerial")
	if ok then
		aerial.open({ focus = true })
	else
		vim.cmd("AerialOpen")
	end
end, { desc = "Aerial: 열기 및 포커스" })
vim.keymap.set("n", "<leader>as", function() require('aerial').fzf() end, { desc = "Aerial: 심볼 검색(fzf)" })

-- 플러그인 초기화는 lua/plugins/harpoon.lua에서 수행
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>ja", function()
	harpoon:list():add()
end, { desc = "Harpoon: 파일 추가" })
vim.keymap.set("n", "<leader>jm", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon: 퀵 메뉴" })
vim.keymap.set("n", "<leader>j1", function()
	harpoon:list():select(1)
end, { desc = "Harpoon: 1번 파일로 이동" })
vim.keymap.set("n", "<leader>j2", function()
	harpoon:list():select(2)
end, { desc = "Harpoon: 2번 파일로 이동" })
vim.keymap.set("n", "<leader>j3", function()
	harpoon:list():select(3)
end, { desc = "Harpoon: 3번 파일로 이동" })
vim.keymap.set("n", "<leader>j4", function()
	harpoon:list():select(4)
end, { desc = "Harpoon: 4번 파일로 이동" })
vim.keymap.set("n", "<leader>jp", function()
	harpoon:list():prev()
end, { desc = "Harpoon: 이전 파일" })
vim.keymap.set("n", "<leader>jn", function()
	harpoon:list():next()
end, { desc = "Harpoon: 다음 파일" })

-- ===== buffer(tab) 이동 시 사이드바(neo-tree/aerial) 보존 =====
-- 사이드바에 포커스가 있어도 메인 코드 창의 버퍼만 변경되도록 래퍼 함수
local function find_main_window()
	local wins = vim.api.nvim_tabpage_list_wins(0)
	for _, win in ipairs(wins) do
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.bo[buf].filetype
		if ft ~= "neo-tree" and ft ~= "aerial" and ft ~= "qf" and ft ~= "Trouble" then
			return win
		end
	end
	return vim.api.nvim_get_current_win()
end

local function goto_buffer(num)
	local cur_win = vim.api.nvim_get_current_win()
	local target_win = find_main_window()
	-- 대상 창에서 버퍼 이동 실행
	vim.api.nvim_set_current_win(target_win)
	vim.cmd("BufferGoto " .. num)
	-- 포커스가 사이드바였다면 포커스 복원
	local cur_buf = vim.api.nvim_win_get_buf(cur_win)
	local cur_ft = vim.bo[cur_buf].filetype
	if (cur_ft == "neo-tree" or cur_ft == "aerial") and cur_win ~= target_win then
		vim.api.nvim_set_current_win(cur_win)
	end
end

-- Alt+숫자 키: 항상 메인 창의 버퍼만 변경
for i = 1, 9 do
	vim.keymap.set("n", "<A-" .. i .. ">", function()
		goto_buffer(i)
	end, { desc = "버퍼로 이동 " .. i })
end
vim.keymap.set("n", "<A-0>", function()
	goto_buffer(0)
end, { desc = "마지막 버퍼로 이동" })
vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { desc = "Barbar: 이전 버퍼" })
vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", { desc = "Barbar: 다음 버퍼" })
vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { desc = "Barbar: 버퍼 왼쪽 이동" })
vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { desc = "Barbar: 버퍼 오른쪽 이동" })
vim.keymap.set("n", "<A-p>", "<Cmd>BufferPin<CR>", { desc = "Barbar: 버퍼 고정" })
vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", { desc = "Barbar: 버퍼 닫기" })
vim.keymap.set("n", "<C-p>", "<Cmd>BufferPick<CR>", { desc = "Barbar: 버퍼 선택" })
vim.keymap.set("n", "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", { desc = "Barbar: 번호순 정렬" })
vim.keymap.set("n", "<leader>bn", "<Cmd>BufferOrderByName<CR>", { desc = "Barbar: 이름순 정렬" })
vim.keymap.set("n", "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>", { desc = "Barbar: 디렉터리순 정렬" })
vim.keymap.set("n", "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>", { desc = "Barbar: 언어순 정렬" })
vim.keymap.set("n", "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", { desc = "Barbar: 윈도우순 정렬" })

-- ===== toggleterm =====
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {
	noremap = true,
	silent = true,
	desc = "Terminal: 일반 모드로 전환",
})
vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm<CR>", {
	noremap = true,
	silent = true,
	desc = "Terminal: 토글",
})

-- ===== vim-bookmarks & fzf-lua =====
vim.keymap.set("n", "mm", "<cmd>BookmarkToggle<cr>", { desc = "Bookmark: 토글" })
vim.keymap.set("n", "mi", "<cmd>BookmarkAnnotate<cr>", { desc = "Bookmark: 주석 추가/편집" })
vim.keymap.set("n", "mc", "<cmd>BookmarkClear<cr>", { desc = "Bookmark: 모두 지우기" })
vim.keymap.set("n", "mn", "<cmd>BookmarkNext<cr>", { desc = "Bookmark: 다음 북마크" })
vim.keymap.set("n", "mp", "<cmd>BookmarkPrev<cr>", { desc = "Bookmark: 이전 북마크" })
-- BookmarkShowAll로 Quickfix에 채운 뒤 fzf-lua quickfix 호출
vim.keymap.set("n", "ml", "<cmd>BookmarkShowAll<cr><cmd>FzfLua quickfix<cr>", { desc = "Bookmark: 목록 보기(fzf)" })

-- ===== fzf-lua =====
local function fzf_lua(cmd)
    return function()
        require('fzf-lua')[cmd]()
    end
end

vim.keymap.set("n", "<leader>fs", fzf_lua("files"), { desc = "FzfLua: 파일 찾기" })
vim.keymap.set("n", "<leader>fg", fzf_lua("live_grep"), { desc = "FzfLua: 텍스트 검색" })
vim.keymap.set("n", "<leader>fb", fzf_lua("buffers"), { desc = "FzfLua: 버퍼 목록" })
vim.keymap.set("n", "<leader>fh", fzf_lua("help_tags"), { desc = "FzfLua: 도움말 태그" })

-- ===== neogen =====
local function neogen_generate(opts)
	return function()
		local ok, neogen = pcall(require, "neogen")
		if not ok then
			vim.notify("Neogen을 불러오지 못했습니다.", vim.log.levels.WARN)
			return
		end
		neogen.generate(opts or {})
	end
end

vim.keymap.set("n", "<leader>ng", "<cmd>Neogen<cr>", { desc = "Neogen: 주석 생성(기본)" })
vim.keymap.set("n", "<leader>nd", neogen_generate({
	annotation_convention = {
		c = "doxygen",
		cpp = "doxygen",
		python = "google_docstrings",
	},
}), { desc = "Neogen: Doxygen 엄격형 프리셋" })
vim.keymap.set("n", "<leader>nc", neogen_generate({
	annotation_convention = {
		cpp = "google_concise",
		python = "google_docstrings",
	},
}), { desc = "Neogen: Google 간결형 프리셋" })

-- ===== trouble =====
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble: 진단 토글(버퍼)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Trouble: 진단 토글(현재 버퍼만)" })
vim.keymap.set(
	"n",
	"<leader>xw",
	"<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.WARN<cr>",
	{ desc = "Trouble: 경고" }
)
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Trouble: 위치 목록" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Trouble: 퀵픽스 목록" })
vim.keymap.set("n", "gR", "<cmd>Trouble lsp toggle focus=true win.position=right<cr>", { desc = "Trouble: LSP 참조" })

-- ===== nvim-dap =====
local function dap_call(method)
	return function()
		local ok, dap = pcall(require, "dap")
		if ok and dap[method] then
			dap[method]()
		end
	end
end

vim.keymap.set("n", "<leader>db", function()
	local ok, dap = pcall(require, "dap")
	if ok then
		dap.toggle_breakpoint()
	end
end, { desc = "DAP: 중단점 토글" })

vim.keymap.set("n", "<leader>dB", function()
	local ok, dap = pcall(require, "dap")
	if not ok then
		return
	end
	local cond = vim.fn.input("중단점 조건 > ")
	if cond ~= "" then
		dap.set_breakpoint(cond)
	end
end, { desc = "DAP: 조건 중단점" })

vim.keymap.set("n", "<leader>dl", function()
	local ok, dap = pcall(require, "dap")
	if not ok then
		return
	end
	local msg = vim.fn.input("로그 메시지 > ")
	if msg ~= "" then
		dap.set_breakpoint(nil, nil, msg)
	end
end, { desc = "DAP: 로그 포인트" })

vim.keymap.set("n", "<leader>dc", dap_call("continue"), { desc = "DAP: 실행/계속" })
vim.keymap.set("n", "<leader>dn", dap_call("step_over"), { desc = "DAP: 다음 줄" })
vim.keymap.set("n", "<leader>di", dap_call("step_into"), { desc = "DAP: 안으로" })
vim.keymap.set("n", "<leader>do", dap_call("step_out"), { desc = "DAP: 밖으로" })
vim.keymap.set("n", "<leader>dr", dap_call("run_to_cursor"), { desc = "DAP: 커서까지 실행" })
vim.keymap.set("n", "<leader>ds", dap_call("run_last"), { desc = "DAP: 마지막 구성" })
vim.keymap.set("n", "<leader>dq", dap_call("terminate"), { desc = "DAP: 세션 종료" })

vim.keymap.set({ "n", "v" }, "<leader>de", function()
	local ok, dapui = pcall(require, "dapui")
	if ok then
		dapui.eval()
	end
end, { desc = "DAP: 값 평가" })

vim.keymap.set("n", "<leader>du", function()
	local ok, dapui = pcall(require, "dapui")
	if ok then
		dapui.toggle({ reset = true })
	end
end, { desc = "DAP: UI 토글" })

-- ===== Git =====
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>", { desc = "Git: 다음 hunk" })
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Git: 이전 hunk" })
vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Git: hunk 스테이지" })
vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Git: hunk 리셋" })
vim.keymap.set("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "Git: 버퍼 스테이지" })
vim.keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Git: hunk 스테이지 되돌리기" })
vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Git: hunk 미리보기" })
vim.keymap.set("n", "<leader>hb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Git: blame 토글" })
vim.keymap.set("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>", { desc = "Git: 현재 diff 보기" })
vim.keymap.set("n", "<leader>hD", "<cmd>Gitsigns diffthis ~<CR>", { desc = "Git: 이전 버전과 diff 보기" })

vim.keymap.set("n", "<leader>gg", function()
	local ok, neogit = pcall(require, "neogit")
	if ok then
		neogit.open()
	end
end, { desc = "Git: Neogit 상태" })

vim.keymap.set("n", "<leader>gC", function()
	local ok, neogit = pcall(require, "neogit")
	if ok then
		neogit.open({ "commit" })
	end
end, { desc = "Git: Neogit 커밋" })

vim.keymap.set("n", "<leader>gdo", function()
	local ok, diffview = pcall(require, "diffview")
	if ok then
		diffview.open()
	end
end, { desc = "Git: Diffview 열기" })

vim.keymap.set("n", "<leader>gdf", function()
	local ok, diffview = pcall(require, "diffview")
	if ok then
		diffview.file_history()
	end
end, { desc = "Git: Diffview 파일 히스토리" })

vim.keymap.set("n", "<leader>gdc", function()
	local ok, diffview = pcall(require, "diffview")
	if ok then
		diffview.close()
	end
end, { desc = "Git: Diffview 닫기" })

-- ===== 기타 유용한 단축키 =====
-- 예시: vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = '파일 저장' })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "LSP: 진단 상세" })

-- 검색 후 하이라이트 제거
vim.keymap.set(
	"n",
	"<Esc>",
	"<Esc>:nohlsearch<CR>",
	{ noremap = true, silent = true, desc = "검색 하이라이트 제거" }
)

-- 모든 파일 저장 및 종료 / 모든 파일 저장
vim.keymap.set(
	"n",
	"<leader>wqa",
	"<cmd>wqa<CR>",
	{ noremap = true, silent = true, desc = "모든 파일 저장 및 종료" }
)
vim.keymap.set("n", "<leader>wa", "<cmd>wa<CR>", { noremap = true, silent = true, desc = "모든 파일 저장" })
vim.keymap.set(
	"n",
	"<leader>qq",
	"<cmd>qa!<CR>",
	{ noremap = true, silent = true, desc = "모든 파일 강제 종료" }
)
