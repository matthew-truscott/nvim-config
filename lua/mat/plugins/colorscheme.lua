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
      background = {
        dark = "wave",
        light = "lotus",
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          DiagnosticUnderlineWarn = { undercurl = false, underline = false }
        }
      end
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
-- return {
--   "thesimonho/kanagawa-paper.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
--   config = function()
--     local kanagawa = require("kanagawa-paper")
--     kanagawa.setup({
--       undercurl = false,
--       transparent = false,
--       gutter = false,
--       dimInactive = true, -- disabled when transparent
--       terminalColors = true,
--       commentStyle = { italic = true },
--       functionStyle = { italic = false },
--       keywordStyle = { italic = false, bold = false },
--       statementStyle = { italic = false, bold = false },
--       typeStyle = { italic = false },
--       colors = { theme = {}, palette = {} }, -- override default palette and theme colors
--       overrides = function(colors) -- override highlight groups
--         local theme = colors.theme
--         return {
--           NormalFloat = { bg = theme.ui.bg },
--           FloatBorder = { bg = "NONE" },
--           DiagnosticUnderlineWarn = { undercurl = false, underline = false },
--           -- Save a hlgroup with dark background and dimmed foreground
--           -- so that you can use it where you still want darker windows.
--           -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
--           NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
--
--           -- Popular plugins that open floats will link to NormalFloat by default;
--           -- set their background accordingly if you wish to keep them dark and borderless
--           LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
--           MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
--           Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
--           PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
--           PmenuSbar = { bg = theme.ui.bg_m1 },
--           PmenuThumb = { bg = theme.ui.bg_p2 },
--         }
--       end,
--     })
--     vim.cmd([[colorscheme kanagawa-paper]])
--   end,
-- }
