-- plugins/trouble.lua
return {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble: Diagnostics (buf)" },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble: Diagnostics (buf only)" },
        {
            "<leader>xw",
            "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.WARN<cr>",
            desc = "Trouble: Warnings",
        },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble: Loclist" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble: Quickfix" },
        { "gR", "<cmd>Trouble lsp toggle focus=true win.position=right<cr>", desc = "Trouble: LSP references" },
    },
    opts = {
        use_diagnostic_signs = true,
        auto_open = false,
        auto_close = false,
        focus = true,
        modes = {
            diagnostics = { -- 기본: 현재 버퍼 진단
                win = { position = "bottom", size = 12 },
            },
        },
    },
    config = function(_, opts)
        require("trouble").setup(opts)
    end,
}
