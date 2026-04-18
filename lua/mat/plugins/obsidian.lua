return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  priority = 50, -- Load after markview (which has priority 49)
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Follow link with gd
    ["gd"] = {
      action = function()
        return "<cmd>ObsidianFollowLink<CR>"
      end,
      opts = { noremap = true, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ["<leader>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    -- Smart action depending on context, either follow link or toggle checkbox.
    ["<cr>"] = {
      action = function()
        return require("obsidian").util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    },
  },
  opts = {
    workspaces = {
      {
        name = "work",
        path = "~/documents/work/",
      },
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "daily",
    },

    -- UI settings
    ui = {
      enable = true,
    },

    -- see below for full list of options 👇
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Ensure conceallevel is set correctly for markdown files
    -- Use a delayed autocmd to run AFTER markview sets conceallevel
    vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
      pattern = "markdown",
      callback = function()
        -- Delay to ensure this runs after markview
        vim.defer_fn(function()
          vim.opt_local.conceallevel = 2
        end, 10)
      end,
    })
  end,
}
