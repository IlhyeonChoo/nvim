-- 리더키 설정
vim.g.mapleader = ' '

-- Set the package manager of NeoVim to lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Install NeoVim Plugins
require("lazy").setup("plugins", {})

-- Set-up the basic configurations
require("options")
require("keymaps")
require("filetypes")
require("lsp.clang_helpers")



-- Install NeoVim Plugins
-- require("lazy").setup("plugins", {})

-- lualine 설정은 plugins/lualine.lua로 이동

-- 몇몇 색상 변경  (모든 플러그인 로드 후 적용)
vim.opt.cursorline = true
local highlight_group = vim.api.nvim_create_augroup("CustomHighlightOverrides", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    group = highlight_group,
    pattern = "*",
    callback = function()
        -- 주석 색 변경
        vim.api.nvim_set_hl(0, "Comment", { fg = "#ffff00", italic = true })

        -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#a89984", bold = true })
        -- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#458588", bold = true })
        -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3c3836" })
        -- vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#000000" })
    end,
})

-- Neovim 시작 시에도 적용되도록 즉시 실행
-- 참고: colorscheme이 로드되면서 이 콜백이 다시 호출될 수 있지만,
-- autocmd 그룹의 clear=true 옵션 덕분에 중복 실행 문제는 없습니다.
pcall(function()
    vim.api.nvim_set_hl(0, "Comment", { fg = "#ffff00", italic = true })
    -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#a89984", bold = true })
    -- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#458588", bold = true })
    -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3c3836" })
    -- vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#000000" })
end)
