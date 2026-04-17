return {
  {
    "danymat/neogen",
    optional = true,
    keys = {
      {
        "<leader>cD",
        function()
          require("neogen").generate({
            annotation_convention = {
              c = "doxygen",
              cpp = "doxygen",
              python = "google_docstrings",
            },
          })
        end,
        desc = "Generate Doxygen Annotations",
      },
      {
        "<leader>cG",
        function()
          require("neogen").generate({
            annotation_convention = {
              cpp = "google_concise",
              python = "google_docstrings",
            },
          })
        end,
        desc = "Generate Concise Annotations",
      },
    },
    opts = function(_, opts)
      local item = require("neogen.types.template").item
      local cpp_google_concise = {
        { nil, "// $1", { no_results = true, type = { "func", "class", "type", "file" } } },
        { nil, "// $1", { type = { "func", "class", "type", "file" } } },
        {
          item.Tparam,
          "//   %s: $1",
          { type = { "func", "class" }, before_first_item = { "//", "// Template Args:" } },
        },
        { item.Parameter, "//   %s: $1", { type = { "func" }, before_first_item = { "//", "// Args:" } } },
        { item.Return, "// $1", { type = { "func" }, before_first_item = { "//", "// Returns:" } } },
      }

      opts.languages = opts.languages or {}
      opts.languages.cpp = vim.tbl_deep_extend("force", opts.languages.cpp or {}, {
        template = {
          annotation_convention = "doxygen",
          google_concise = cpp_google_concise,
        },
      })
      opts.languages.python = vim.tbl_deep_extend("force", opts.languages.python or {}, {
        template = {
          annotation_convention = "google_docstrings",
        },
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "chrisgrieser/nvim-scissors",
    commit = "855ce6b",
    cmd = { "ScissorsAddNewSnippet", "ScissorsEditSnippet" },
    dependencies = { "folke/snacks.nvim" },
    main = "scissors",
    opts = {
      snippetDir = vim.fn.stdpath("config") .. "/snippets",
    },
  },
}
