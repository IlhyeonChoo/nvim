-- neogen: 함수, 클래스 등에 대한 주석(Annotation)을 자동으로 생성해주는 플러그인
return {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        require('neogen').setup({
            snippet_engine = "luasnip"
        })
    end,
    keys = {
        {
            "<leader>ng",
            function()
                require("neogen").generate()
            end,
            desc = "Neogen: 주석 생성",
        },
    },
}
