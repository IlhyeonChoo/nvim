return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local function hex_from_hl(name, fallback)
        local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
        if ok and hl and hl.fg then
          return string.format("#%06x", hl.fg)
        end
        return fallback
      end

      local indent_color = hex_from_hl("IblIndent", "#61afef")

      return {
        chunk = {
          enable = true,
          use_treesitter = true,
          notify = false,
          style = {
            { fg = indent_color },
          },
          chars = {
            horizontal_line = "━",
            vertical_line = "┃",
            left_top = "┏",
            left_bottom = "┗",
            right_arrow = "━",
          },
        },
        indent = {
          enable = false,
        },
        line_num = {
          enable = true,
          style = "#b4befe",
        },
        blank = {
          enable = false,
        },
      }
    end,
  },
}
