return {
  build = "cargo build --release",
  "saghen/blink.cmp",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
      implementation = "rust",
    },
    keymap = {
      -- set to 'none' to disable the 'default' preset
      preset = "none",
      ["<A-k>"] = { "select_prev", "fallback" },
      ["<A-j>"] = { "select_next", "fallback" },
      ["<A-l>"] = { "accept", "fallback" },
      ["<A-h>"] = { "cancel", "fallback" },
    },
    signature = { enabled = true },
    appearance = {
      nerd_font_variant = "mono",
    },
  },
}
