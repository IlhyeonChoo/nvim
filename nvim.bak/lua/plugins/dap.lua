-- nvim-dap: 언어별 디버깅 환경 구성
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Mason 기반 디버거 어댑터 설치
    require("mason-nvim-dap").setup({
      ensure_installed = {
        "codelldb",
        "python",
      },
      automatic_installation = true,
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    })

    -- Python 디버깅 설정
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

    dap.configurations.python = {
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
    }

    -- C/C++ 디버깅 설정 (codelldb)
    local dap_utils = require("dap.utils")
    local function split_args(input)
      if not input or input == "" then
        return {}
      end
      return vim.split(input, " ", { trimempty = true })
    end

    local cpp_config = {
      {
        name = "Launch executable",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("실행 파일 경로 > ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = function()
          local input = vim.fn.input("프로그램 인자 (공백 구분) > ")
          return split_args(input)
        end,
      },
      {
        name = "Attach to process",
        type = "codelldb",
        request = "attach",
        pid = dap_utils.pick_process,
        cwd = "${workspaceFolder}",
      },
    }

    dap.configurations.cpp = cpp_config
    dap.configurations.c = cpp_config

    -- UI 연동 및 표시 옵션
    require("nvim-dap-virtual-text").setup({
      commented = true,
    })

    dapui.setup({
      floating = { border = "rounded" },
      controls = { enabled = false },
    })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticError", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "S", texthl = "DiagnosticInfo", linehl = "DiagnosticUnderlineInfo", numhl = "" })
  end,
}
