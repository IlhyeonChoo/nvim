return {
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
      {
        "<leader>gn",
        function()
          require("neogit").open()
        end,
        desc = "Neogit",
      },
      {
        "<leader>gC",
        function()
          require("neogit").open({ "commit" })
        end,
        desc = "Neogit Commit",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    opts = {
      disable_commit_confirmation = true,
      integrations = {
        diffview = true,
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History" },
      { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
      file_panel = {
        win_config = { position = "left", width = 35 },
      },
    },
  },
  {
    "MattesGroeger/vim-bookmarks",
    keys = {
      { "<leader>Bm", "<cmd>BookmarkToggle<cr>", desc = "Bookmark Toggle" },
      { "<leader>Bi", "<cmd>BookmarkAnnotate<cr>", desc = "Bookmark Annotate" },
      { "<leader>Bc", "<cmd>BookmarkClear<cr>", desc = "Bookmark Clear" },
      { "<leader>Bn", "<cmd>BookmarkNext<cr>", desc = "Bookmark Next" },
      { "<leader>Bp", "<cmd>BookmarkPrev<cr>", desc = "Bookmark Prev" },
      { "<leader>Bl", "<cmd>BookmarkShowAll<cr>", desc = "Bookmark List" },
    },
    init = function()
      vim.g.bookmark_no_default_key_mappings = 1
      vim.g.bookmark_sign = "🔖"
      vim.g.bookmark_annotation_sign = "📝"
      vim.g.bookmark_highlight_lines = 1
      vim.g.bookmark_save_per_working_dir = 1
      vim.g.bookmark_auto_save = 1
    end,
  },
}
