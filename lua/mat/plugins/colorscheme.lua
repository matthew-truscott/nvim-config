return {
  -- "luisiacc/gruvbox-baby",
  "rebelot/kanagawa.nvim",
  priority = 1000, -- make sure to load this before all other start plugins
  config = function()
    -- load the colorscheme here
    -- vim.g.gruvbox_baby_transparent_mode = "true"
    -- vim.cmd([[colorscheme gruvbox-baby]])
    local kanagawa = require("kanagawa")
    kanagawa.setup({
      transparent = true,
      theme = "dragon",
    })
    vim.cmd([[colorscheme kanagawa]])
  end,
}
