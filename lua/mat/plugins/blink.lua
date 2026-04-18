return {
  "saghen/blink.cmp",
  build = "cargo build --release",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "lazydev" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
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
