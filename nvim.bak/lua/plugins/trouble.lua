-- plugins/trouble.lua
return {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
