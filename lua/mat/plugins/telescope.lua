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
            ["<h>"] = actions.cycle_history_prev,
            ["<l>"] = actions.cycle_history_next,
            ["dd"] = actions.delete_buffer,
          },
        },
        layout_config = {
          vertical = { width = 0.9 },
        },
        layout_strategy = "vertical",
        path_display = { shorten = 2, truncate = 5 },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    local builtin = require("telescope.builtin")

    keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
    keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "Telescope live grep" })
    keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
    keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
  end,
}
