-- OSC52를 활용해 원격/터미널 사이의 클립보드를 연동한다.
return {
  "ojroques/nvim-osc52",
  event = "VeryLazy",
  config = function()
    local ok, osc52 = pcall(require, "osc52")
    if not ok then
      return
    end

    osc52.setup({
      max_length = 0,
      silent = true,
      trim = false,
    })

    local function copy_register(regname)
      local register = regname == "" and '"' or regname
      osc52.copy_register(register)
    end

    local yank_group = vim.api.nvim_create_augroup("clipboard_osc52", { clear = true })
    vim.api.nvim_create_autocmd("TextYankPost", {
      group = yank_group,
      callback = function()
        if vim.v.event.operator == "y" then
          copy_register(vim.v.event.regname)
        end
      end,
    })

    local function osc_copy(lines, regtype)
      local text = table.concat(lines, "\n")
      if regtype == "V" then
        text = text .. "\n"
      end
      osc52.copy(text)
    end

    local is_ssh = vim.env.SSH_TTY or vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT
    if is_ssh then
      vim.g.clipboard = {
        name = "osc52",
        copy = {
          ['+'] = osc_copy,
          ['*'] = osc_copy,
        },
        paste = {
          ['+'] = function()
            return false
          end,
          ['*'] = function()
            return false
          end,
        },
      }
    end
  end,
}
