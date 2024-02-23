return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      sync_root_with_cwd = true,
      view = {
        preserve_window_proportions = false,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      renderer = {
        icons = {
          git_placement = "signcolumn",
          glyphs = {
            git = {
              unstaged = "",
              staged = "󰱒",
              untracked = "",
            }
          }
        }
      }
    })

    vim.api.nvim_create_autocmd({ "QuitPre" }, {
      callback = function()
        local invalid_win = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match("NvimTree_") ~= nil then
            table.insert(invalid_win, w)
          end
        end
        if #invalid_win == #wins - 1 then
          -- Should quit, so we close all invalid windows.
          for _, w in ipairs(invalid_win) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end,
    })

    -- set keymaps
    local keymap = vim.keymap                                                                  -- for conciseness

    keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
  end,
}
