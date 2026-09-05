return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    -- WCAG relative luminance / contrast ratio, used to pick the readable text
    -- colour for an accent block. A fixed light-or-dark rule doesn't survive the
    -- variant flip -- lotus accents are dark on a light bar, wave's are light on
    -- a dark one -- so let contrast decide instead of hand-picking a fg per mode.
    local function luminance(hex)
      local function channel(c)
        c = tonumber(hex:sub(c, c + 1), 16) / 255
        return c <= 0.03928 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4
      end
      return 0.2126 * channel(2) + 0.7152 * channel(4) + 0.0722 * channel(6)
    end

    local function contrast(a, b)
      local la, lb = luminance(a), luminance(b)
      if la < lb then
        la, lb = lb, la
      end
      return (la + 0.05) / (lb + 0.05)
    end

    -- The candidate that reads best on `accent`. Pass the theme's light and dark
    -- extremes; which of them *is* the light one depends on the variant, which is
    -- exactly what this exists to avoid caring about.
    local function readable_on(accent, candidates)
      local best, best_cr = candidates[1], -1
      for _, c in ipairs(candidates) do
        local ratio = contrast(accent, c)
        if ratio > best_cr then
          best, best_cr = c, ratio
        end
      end
      return best
    end

    -- Build the statusline theme from kanagawa's own colours for the *current*
    -- theme, so the bar follows wave/lotus/dragon (and any &background flip)
    -- without a second palette to keep in sync. Mode accents come from the
    -- semantic groups rather than raw palette names for the same reason.
    local function build_theme()
      local ok, colors = pcall(require("kanagawa.colors").setup)
      if not ok then
        return "auto" -- kanagawa not loaded yet; lualine derives from highlights
      end
      local ui, syn, diag = colors.theme.ui, colors.theme.syn, colors.theme.diag

      -- Flat bar in the kanagawa house style: an accent block, a slightly
      -- raised b section carrying the same accent as text, then a recessed body.
      local function section(accent)
        return {
          a = { bg = accent, fg = readable_on(accent, { ui.bg_m3, ui.bg, ui.fg }), gui = "bold" },
          b = { bg = ui.bg_p1, fg = accent },
          c = { bg = ui.bg_m3, fg = ui.fg_dim },
        }
      end

      return {
        normal = section(syn.fun),
        insert = section(diag.ok),
        visual = section(syn.keyword),
        replace = section(diag.error),
        command = section(syn.identifier),
        terminal = section(syn.type),
        inactive = {
          a = { bg = ui.bg_m3, fg = ui.nontext, gui = "bold" },
          b = { bg = ui.bg_m3, fg = ui.nontext },
          c = { bg = ui.bg_m3, fg = ui.nontext },
        },
      }
    end

    local function apply()
      lualine.setup({
        options = {
          icons_enabled = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          theme = build_theme(),
        },
        sections = {
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
            },
            { "encoding" },
            {
              "filename",
              path = 1,
            },
            { "fileformat" },
            { "filetype" },
          },
        },
      })
    end

    apply()

    -- Rebuild when the colorscheme reloads. kanagawa reloads on every &background
    -- flip (e.g. a live system light/dark switch), so this keeps the bar in sync.
    vim.api.nvim_create_autocmd("ColorScheme", { callback = apply })
  end,
}
