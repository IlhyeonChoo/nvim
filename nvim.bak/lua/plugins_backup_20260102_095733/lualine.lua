-- lualine: 상태라인 플러그인
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/noice.nvim",
  },
  config = function()
    -- noice statusline helpers (robust to missing plugin)
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

    -- aerial statusline helpers (support both old/new APIs)
    local function aerial_location_get()
      local ok, aerial = pcall(require, "aerial")
      if not ok then
        return ""
      end
      local getter = (aerial.statusline and aerial.statusline.get_location) or aerial.get_location
      if type(getter) == "function" then
        local ok2, loc = pcall(getter)
        if ok2 and loc then
          return loc
        end
      end
      return ""
    end

    local function aerial_location_has()
      local ok, aerial = pcall(require, "aerial")
      if not ok then
        return false
      end
      local has = (aerial.statusline and aerial.statusline.has_symbols) or aerial.is_available
      if type(has) == "function" then
        local ok2, res = pcall(has)
        return ok2 and res or false
      end
      return false
    end

    require("lualine").setup({
      options = {
        theme = "catppuccin",
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
            aerial_location_get,
            cond = aerial_location_has,
          },
        },
      },
    })
  end,
}
