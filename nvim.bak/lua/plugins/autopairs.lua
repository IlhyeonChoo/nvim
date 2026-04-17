-- autopairs: 괄호, 따옴표 등 쌍을 자동으로 완성해주는 플러그인
return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/nvim-cmp",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        -- 기본 설정: Tree-sitter 사용, 빠른 래핑(fast-wrap) 활성화
        require("nvim-autopairs").setup({
            check_ts = true,
            fast_wrap = {},
            disable_filetype = { "TelescopePrompt", "text" },
        })

        -- CMP 확정(confirm) 시 자동으로 괄호 닫기
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

        -- triple quote 예외 규칙 추가
        local Rule = require("nvim-autopairs.rule")
        local npairs = require("nvim-autopairs")

            npairs.add_rules({
                Rule("'''", "'''", "python")
                    :with_pair(function(opts)
                          return opts.line:sub(opts.col - 2, opts.col) ~= "'''"
                    end),
                Rule('"""', '"""', "python")
                    :with_pair(function(opts)
                          return opts.line:sub(opts.col - 2, opts.col) ~= '"""'
                    end),
            })
        end,
}