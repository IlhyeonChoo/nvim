
-- macOS (검은 배경)용 색상 설정
vim.opt.cursorline = true

local highlight_group = vim.api.nvim_create_augroup("CustomHighlightOverrides_macOS", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
    group = highlight_group,
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "Comment",      { fg = "#8a81a3", italic = true })
        vim.api.nvim_set_hl(0, "LineNr",       { fg = "#586374" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e6b422", bold = true })
        vim.api.nvim_set_hl(0, "CursorLine",   { bg = "NONE" })
    end,
})

pcall(function()
    vim.api.nvim_set_hl(0, "Comment",      { fg = "#8a81a3", italic = true })
    vim.api.nvim_set_hl(0, "LineNr",       { fg = "#586374" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e6b422", bold = true })
    vim.api.nvim_set_hl(0, "CursorLine",   { bg = "NONE" })
end)
