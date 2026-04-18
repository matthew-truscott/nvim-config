return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {},
  config = function()
    -- import nvim-autopairs
    local autopairs = require("nvim-autopairs")

    -- configure autopairs
    autopairs.setup({
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
      },
    })

    -- Julia endwise rules: auto-insert "end" for block keywords
    local endwise = require("nvim-autopairs.ts-rule").endwise
    autopairs.add_rules({
      endwise("struct%s.+", "end", "julia", nil),
      endwise("mutable struct%s.+", "end", "julia", nil),
      endwise("function%s.+", "end", "julia", nil),
      endwise("if%s.+", "end", "julia", nil),
      endwise("for%s.+", "end", "julia", nil),
      endwise("while%s.+", "end", "julia", nil),
      endwise("begin$", "end", "julia", nil),
      endwise("let$", "end", "julia", nil),
      endwise("do$", "end", "julia", nil),
      endwise("module%s.+", "end", "julia", nil),
    })
  end,
}
