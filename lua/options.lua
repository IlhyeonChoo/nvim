-- Neovim 전역 옵션 설정 (PEP 8 스타일 주석)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.bo.softtabstop = 2
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.cindent = false

-- 줄 번호 표시 등 추가 옵션 (init_numbering.lua 참고)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5

local is_remote = vim.env.SSH_TTY or vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT
if not is_remote then
    vim.opt.clipboard = "unnamedplus"
end

-- 외부(다른 세션/사용자)에서 파일이 수정되면 자동으로 다시 읽기
-- 주의: 현재 버퍼에 미저장 변경이 있으면 안전을 위해 자동 덮어쓰지 않고 경고만 뜹니다.
vim.opt.autoread = true
local autoread_group = vim.api.nvim_create_augroup("AutoReadOnExternalChange", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    group = autoread_group,
    callback = function()
        if vim.fn.mode() ~= "c" then
            vim.cmd("checktime")
        end
    end,
})


-- 배경 투명화 설정
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
    end,
})

-- 초기 로드 시에도 한 번 실행
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
