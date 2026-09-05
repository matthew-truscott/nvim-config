return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Neo-tree (toggle)" },
    { "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Neo-tree (reveal current file)" },
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    source_selector = {
      winbar = true,
      statusline = false,
      sources = {
        { source = "filesystem", display_name = " 󰉓 Files " },
        { source = "buffers", display_name = " 󰈚 Bufs " },
        { source = "git_status", display_name = " 󰊢 Git " },
        { source = "document_symbols", display_name = " 󰫧 Symbols " },
      },
    },
    window = {
      position = "left",
      width = 40,
      mappings = {
        ["g/"] = function(state)
          local node = state.tree:get_node()
          local cwd = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
          require("snacks").picker.grep({ cwd = cwd })
        end,
      },
    },
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
}
