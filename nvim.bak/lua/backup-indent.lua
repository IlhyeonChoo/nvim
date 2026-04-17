-- 하이라이트 그룹 설정
 local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}



return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        -- 기본 설정
        indent = {
            char = "│",
            tab_char = "│",
            highlight = highlight,
        },
        scope = { 
            enabled = true,
            show_start = false,
            show_end = false,
            highlight = {
              "RainbowRed", "RainbowYellow",
              "RainbowBlue", "RainbowOrange",
              "RainbowGreen", "RainbowViolet",
              "RainbowCyan",
            },
        },
        exclude = {
            filetypes = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
        },
    },
    config = function(_, opts)
        -- 기본 설정 적용
        require("ibl").setup(opts)

        -- 하이라이트 그룹 정의 (원하는 색상으로 수정 가능)
        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
          vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
          vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
          vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
          vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
          vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
          vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        end)

        -- 특정 파일 타입에 대한 들여쓰기 비활성화
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
            callback = function()
                vim.b.miniindentscope_disable = true
                vim.b.ibl_enabled = false
            end,
        })
    end,
}
