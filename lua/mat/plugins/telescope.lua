return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to previous result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-h>"] = actions.cycle_history_prev,
            ["<C-l>"] = actions.cycle_history_next,
          },
          n = {
            ["<k>"] = actions.move_selection_previous, -- move to previous result
            ["<j>"] = actions.move_selection_next, -- move to next result
          },
        },
        layout_config = {
          vertical = { width = 0.9 }
        },
        layout_strategy = "vertical",
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find string in cwd" })
  end,
}
