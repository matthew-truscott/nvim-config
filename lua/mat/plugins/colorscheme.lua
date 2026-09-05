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
      compile = true,
      undercurl = true,
      transparent = false,
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus",
      },
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = false },
      statementStyle = { bold = true },
      overrides = function()
        return {
          DiagnosticUnderlineWarn = { undercurl = false, underline = false },
        }
      end,
    })
    -- Re-apply manual highlight tweaks on every (re)load of the scheme. kanagawa
    -- reloads automatically whenever &background flips -- including when the
    -- terminal reports a live system light/dark switch (DEC mode 2031) -- so
    -- these must live in a ColorScheme autocmd, not run once at setup, or they'd
    -- be lost the moment you switch themes.
    local function apply_overrides()
      vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = "NONE", bg = "NONE" })
      vim.api.nvim_set_hl(0, "FloatBorder", { ctermbg = "NONE", bg = "NONE" })
      if vim.o.background == "light" then
        vim.api.nvim_set_hl(0, "NonText", { fg = "#C8C093" })
        vim.api.nvim_set_hl(0, "Whitespace", { fg = "#DCD7BA" })
        vim.api.nvim_set_hl(0, "SpecialKey", { fg = "#C8C093" })
      end
    end

    -- Registered before the initial `colorscheme` call so it also fires on load.
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "kanagawa",
      callback = apply_overrides,
    })

    vim.cmd([[colorscheme kanagawa]])
  end,
}
