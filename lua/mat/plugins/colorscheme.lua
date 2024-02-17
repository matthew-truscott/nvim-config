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
      transparent = false,
      theme = "wave",
    })
    vim.cmd([[colorscheme kanagawa]])

    vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = "NONE", bg = "NONE" })
    vim.api.nvim_set_hl(0, "FloatBorder", { ctermbg = "NONE", bg = "NONE" })

    -- TODO move these global?

    -- Function to set highlight with a hex color
    local function set_highlight(group, hex_color)
      vim.api.nvim_set_hl(0, group, { fg = hex_color })
    end

    if vim.opt.background._value == "light" then
      set_highlight("NonText", "#C8C093")
      set_highlight("Whitespace", "#DCD7BA")
      set_highlight("SpecialKey", "#C8C093")
    end
  end,
}
