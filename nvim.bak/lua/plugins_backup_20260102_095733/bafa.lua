-- bafa: 미니멀한 버퍼 탐색기 및 관리자 플러그인
return {
    "mistweaverco/bafa.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
        require("bafa").setup()
    end,
    keys = {
        {
            "<leader>bb",
            "<cmd>Bafa<cr>",
            desc = "Bafa: 버퍼 목록",
        },
    },
}
