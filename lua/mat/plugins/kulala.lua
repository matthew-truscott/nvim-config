return {
  "mistweaverco/kulala.nvim",
  keys = {
    {
      "<leader>rs",
      function()
        require("kulala").run()
      end,
      desc = "Send request",
    },
    {
      "<leader>ra",
      function()
        require("kulala").run_all()
      end,
      desc = "Send all requests",
    },
    {
      "<leader>rb",
      function()
        require("kulala").scratchpad()
      end,
      desc = "Open scratchpad",
    },
    {
      "<leader>re",
      function()
        require("kulala").set_selected_env()
      end,
      desc = "Select environment",
    },
  },
  ft = { "http", "rest" },
  opts = {
    global_keymaps = false,
    global_keymaps_prefix = "<leader>r",
    kulala_keymaps_prefix = "",
    ui = {
      split_direction = "horizontal",
      max_response_size = 524000,
      win_opts = {
        wo = { wrap = true },
      },
    },
  },
}
