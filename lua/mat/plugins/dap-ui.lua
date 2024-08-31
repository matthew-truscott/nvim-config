return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  opts = {
    icons = {
      expanded = "󰅀",
      collapsed = "󰅂",
      current_frame = "󰅂",
    },
    layouts = {
      {
        elements = {
          {
            id = "scopes",
            size = 0.70,
          },
          {
            id = "breakpoints",
            size = 0.10,
          },
          {
            id = "stacks",
            size = 0.20,
          },
        },
        position = "left",
        size = 50,
      },
      {
        elements = { "console", "watches" },
        position = "bottom",
        size = 15,
      },
    },
    expand_lines = false,
    controls = {
      enabled = false,
    },
    floating = {
      border = "rounded",
    },
    render = {
      indent = 2,
      -- Hide variable types as C++'s are verbose
      max_type_length = 0,
    },
  },
  keys = {
    {
      "<leader>d1",
      function()
        require("dapui").toggle({ reset = true })
      end,
      desc = "Toggle DAP UI",
    },
    {
      "<leader>d2",
      function()
        require("dapui").eval()
      end,
      desc = "DAP Eval",
    },
    {
      "<leader>d3",
      function()
        require("dapui").float_element("breakpoints")
      end,
      desc = "DAP List Breakpoints",
    },
  },
}
