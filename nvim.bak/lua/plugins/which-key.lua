-- which-key: 키 바인딩 가이드 팝업을 표시해주는 플러그인
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "WhichKey: 현재 버퍼 키맵",
    },
  },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    plugins = {
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    spec = {
      { "<leader>", group = "Leader" },
      { "<leader>a", group = "Aerial" },
      { "<leader>b", group = "Buffers" },
      { "<leader>d", group = "DAP" },
      { "<leader>f", group = "Files / Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git Hunk" },
      { "g", group = "Goto" },
      { "<leader>j", group = "Harpoon" },
      { "<leader>l", group = "LSP" },
      { "<leader>m", group = "Markdown" },
      { "m", group = "Bookmarks" },
      { "<leader>n", group = "Neogen" },
      { "<leader>q", group = "Quit" },
      { "<leader>w", group = "Write" },
      { "<leader>x", group = "Trouble / Diagnostics" },
      { "<leader>z", group = "Obsidian" },
    },
  },
}
