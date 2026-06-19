return {
  "saghen/blink.cmp",
  -- Pinned to the commit just before the `types.catchall()` migration, which
  -- silently drops all custom keymaps (custom keys become invisible to pairs()).
  -- Upstream regression: https://github.com/saghen/blink.cmp/issues/2550
  -- Remove both `commit` pins once that issue is fixed, then `:Lazy update`.
  commit = "0194153",
  dependencies = {
    { "saghen/blink.lib", commit = "220979f" },
  },
  build = function()
    -- build the fuzzy matcher, wait up to 60 seconds
    -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
    require("blink.cmp").build():wait(60000)
  end,
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
