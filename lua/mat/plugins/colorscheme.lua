return {
    "luisiacc/gruvbox-baby",
    priority = 1000, -- make sure to load this before all other start plugins
    config = function()
      -- load the colorscheme here
      vim.g.gruvbox_baby_transparent_mode = "true"
      vim.cmd([[colorscheme gruvbox-baby]])
    end,
}
