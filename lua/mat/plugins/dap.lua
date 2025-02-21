return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- Runs preLaunchTask / postDebugTask if present
    { "stevearc/overseer.nvim", config = true },
    "williamboman/mason.nvim",
  },
  keys = {
    {
      "<leader>ds",
      function()
        local widgets = require("dap.ui.widgets")
        widgets.centered_float(widgets.scopes, { border = "rounded" })
      end,
      desc = "DAP Scopes",
    },
    { "<leader>dx", "<CMD>DapTerminate<CR>", desc = "DAP Terminate" },
    { "<leader>dc", "<CMD>DapContinue<CR>", desc = "DAP Continue" },
    {
      "<leader>d.",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to Cursor",
    },
    { "<leader>db", "<CMD>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
    { "<leader>dn", "<CMD>DapStepOver<CR>", desc = "Step Over" },
    { "<leader>di", "<CMD>DapStepInto<CR>", desc = "Step Into" },
    { "<leader>do", "<CMD>DapStepOut<CR>", desc = "Step Out" },
  },
  config = function()
    -- Signs
    local sign = vim.fn.sign_define

    local dap_round_groups = { "DapBreakpoint", "DapBreakpointCondition", "DapBreakpointRejected", "DapLogPoint" }
    for _, group in pairs(dap_round_groups) do
      sign(group, { text = "●", texthl = group })
    end

    local dap = require("dap")
    local overseer = require("overseer")

    overseer.enable_dap()

    local pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
      else
        return "/usr/bin/python"
      end
    end

    -- Adapters
    -- Python
    dap.adapters.python = function(cb, config)
      if config.request == "attach" then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or "localhost"
        cb({
          type = "server",
          port = assert(port, "`connect.port` is required for a python `attach` configuration"),
          host = host,
          options = {
            source_filetype = "python",
          },
        })
      else
        local debugpy = require("mason-registry").get_package("debugpy")
        cb({
          type = "executable",
          command = debugpy:get_install_path() .. "/venv/bin/python3",
          args = { "-m", "debugpy.adapter" },
          options = {
            source_filetype = "python",
          },
        })
      end
    end

    -- Configurations
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = pythonPath(),
      },
    }
  end,
}
