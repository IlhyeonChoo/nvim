-- hlchunk: 현재 블록 범위를 곡선 형태로 강조해주는 플러그인
return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local function hex_from_hl(name, fallback)
      local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
      if ok and hl and hl.fg then
        return string.format("#%06x", hl.fg)
      end
      return fallback
    end

    local indent_color = hex_from_hl("RainbowBlue", "#61afef")

    require("hlchunk").setup({
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
        enable = false, -- indent-blankline이 들여쓰기를 담당하므로 비활성화
      },
      line_num = {
        enable = true,
        style = "#b4befe",
      },
      blank = {
        enable = false,
      },
    })
  end,
}
