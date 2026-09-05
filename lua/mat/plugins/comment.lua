return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- context-aware commentstring for embedded languages (JSX/TSX, Vue, ...).
    -- Works with native treesitter parsers; does NOT need the nvim-treesitter plugin.
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")

    -- let the Comment.nvim pre_hook drive commentstring resolution, not an autocmd
    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })

    -- enable comment
    comment.setup({
      -- pick the correct commentstring based on the treesitter node under the cursor
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      toggler = {
        line = "<leader>cc",
        block = "<leader>cb",
      },
      -- opleader left at the plugin defaults (gc/gb). Previously overridden to
      -- <leader>gc/<leader>gb, which collided with the git prefix (gitsigns
      -- blame, diffview, lazygit).
    })
  end,
}
