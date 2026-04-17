-- treesitter: 코드 구문 분석을 통해 더 정확한 하이라이팅, 들여쓰기 등을 제공하는 플러그인
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
            "c", "lua", "vim", "vimdoc", "query",
            "elixir", "heex",
            "javascript", "typescript", "tsx",
            "html", "css",
            "go", "java", "c_sharp",
            "make", "cmake", "dockerfile",
            "ocaml", "latex", "markdown", "yaml"
          },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
 }
