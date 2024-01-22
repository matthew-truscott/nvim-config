return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    local indent = require("ibl")
    indent.setup({
      indent = { char = "│" },
      whitespace = {
        highlight = { "Whitespace", "NonText" },
      },
      scope = { show_start = false, show_end = false },
      exclude = {
        buftypes = {
          "nofile",
          "terminal",
        },
        filetypes = {
          "help",
          "lazy",
          "LazyGit",
        },
      },
    })
  end,
}
