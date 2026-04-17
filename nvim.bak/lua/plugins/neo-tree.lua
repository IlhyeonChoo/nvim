-- neo-tree: 파일 탐색기, git 상태, 버퍼 목록 등을 보여주는 사이드바 플러그인
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      -- 파일을 열어도 네오트리가 사라지지 않도록 (트리 창을 대체하지 않음)
      close_if_last_window = false,
      open_files_do_not_replace_types = { "terminal", "trouble", "qf", "neo-tree" },
      window = {
        position = "right",
        width = 30,
      },
    })
  end,
  init = function()
    local group = vim.api.nvim_create_augroup("neotree_auto_open", { clear = true })
    local function open_neotree_right()
      local ok, cmd = pcall(require, "neo-tree.command")
      if ok then
        cmd.execute({ action = "show", position = "right", source = "filesystem", reveal = false })
      else
        vim.cmd("Neotree show right")
      end
    end
    -- -- 네오빔 시작 시 우측에 Neo-tree 표시
    -- vim.api.nvim_create_autocmd("VimEnter", {
    --     group = group,
    --     callback = open_neotree_right,
    -- })
    -- -- 탭에 들어올 때마다 우측에 Neo-tree 표시
    -- vim.api.nvim_create_autocmd("TabEnter", {
    --     group = group,
    --     callback = open_neotree_right,
    -- })
  end,
}
