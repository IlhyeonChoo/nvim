-- lsp_signature: 함수를 작성할 때 매개변수 정보를 실시간으로 보여주는 플러그인
return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
        bind = true, -- 필수
        handler_opts = {
            border = "rounded"
        },
        hint_prefix = "󱄑 ",
    },
    config = function(_, opts)
        require('lsp_signature').setup(opts)
    end
}
