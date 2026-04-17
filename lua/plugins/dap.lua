local function python_path()
  local venv = vim.env.VIRTUAL_ENV
  if venv and venv ~= "" then
    return venv .. "/bin/python"
  end
  if vim.fn.executable("python3") == 1 then
    return "python3"
  end
  if vim.fn.executable("python") == 1 then
    return "python"
  end
  return "python3"
end

local function split_args(input)
  if not input or input == "" then
    return {}
  end
  return vim.split(input, " ", { trimempty = true })
end

return {
  {
    "mason-org/mason.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "debugpy" })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      dap.configurations.python = vim.list_extend(dap.configurations.python or {}, {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = python_path,
        },
        {
          type = "python",
          request = "launch",
          name = "Launch module",
          module = function()
            return vim.fn.input("Module > ")
          end,
          pythonPath = python_path,
        },
        {
          type = "python",
          request = "attach",
          name = "Attach (localhost)",
          connect = function()
            local host = vim.fn.input("Host [127.0.0.1] > ")
            local port = tonumber(vim.fn.input("Port [5678] > "))
            return {
              host = host ~= "" and host or "127.0.0.1",
              port = port or 5678,
            }
          end,
          pythonPath = python_path,
        },
      })

      for _, lang in ipairs({ "c", "cpp" }) do
        dap.configurations[lang] = vim.list_extend(dap.configurations[lang] or {}, {
          {
            name = "Launch executable with args",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = function()
              return split_args(vim.fn.input("Program args > "))
            end,
          },
        })
      end
    end,
  },
}
