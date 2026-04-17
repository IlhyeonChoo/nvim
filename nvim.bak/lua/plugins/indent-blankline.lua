-- indent-blankline: 들여쓰기 라인을 시각적으로 표시해주는 플러그인
-- 하이라이트 그룹 이름 정의
local rainbow = {
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
    main   = "ibl",
    event  = { "BufReadPost", "BufNewFile" },

    -- 플러그인 옵션
    opts = {
      indent = {
        char      = "┋",        -- 굵은 들여쓰기 선
        tab_char  = "┋",
        highlight = rainbow,
      },
      scope = {
        enabled         = true,
        show_start      = true,
        show_end        = true,
        show_exact_scope = true,
        highlight       = { "IblScope" },
        char            = "┋",
      },
      exclude = {
        filetypes = {
          "help", "alpha", "dashboard", "neo-tree",
          "Trouble", "lazy", "mason", "notify",
          "toggleterm", "lazyterm",
        },
      },
    },

    -- 설정 적용
    config = function(_, opts)
        -- 1️⃣ 먼저 하이라이트 그룹을 등록
        vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#56B6C2" })
        vim.api.nvim_set_hl(0, "IblScope",      { fg = "#b4befe" })

        -- 커서가 속한 블록의 색상을 Treesitter 범위에 맞춰 적용
        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

        -- 2️⃣ 그다음 플러그인을 초기화
        require("ibl").setup(opts)
    end,
  }
