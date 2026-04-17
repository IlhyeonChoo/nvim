-- lualine: 상태라인 플러그인
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/noice.nvim",
  },
  config = function()
    local function noice_mode_get()
      local ok, noice = pcall(require, "noice")
      if ok and noice.api and noice.api.statusline and noice.api.statusline.mode then
        return noice.api.statusline.mode.get()
      end
      return ""
    end

    local function noice_mode_has()
      local ok, noice = pcall(require, "noice")
      if ok and noice.api and noice.api.statusline and noice.api.statusline.mode then
        return noice.api.statusline.mode.has()
      end
      return false
    end

    require("lualine").setup({
      options = {
        theme = "one_monokai",
        globalstatus = true,
      },
      sections = {
        lualine_x = {
          {
            noice_mode_get,
            cond = noice_mode_has,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_c = {
          { "filename" },
          {
            function()
              local ok, aerial = pcall(require, "aerial")
              if ok then
                return aerial.get_location()
              end
              return ""
            end,
            cond = function()
              local ok, aerial = pcall(require, "aerial")
              return ok and aerial.is_available()
            end,
          },
        },
      },
    })
  end,
}
