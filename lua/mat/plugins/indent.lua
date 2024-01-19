return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = { char = "▏" },
    scope = { show_start = false, show_end = false },
    exclude = {
      buftypes = {
        "nofile",
        "terminal",
      },
      filetypes = {
        "help",
        "lazy",
        "NvimTree",
      }
    }
  }
}
