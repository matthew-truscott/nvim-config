return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {},
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")

    -- enable comment
    comment.setup({
      toggler = {
        line = "<leader>cc",
        block = "<leader>cb",
      },
      opleader = {
        line = "<leader>gc",
        block = "<leader>gb",
      },
    })
  end,
}
