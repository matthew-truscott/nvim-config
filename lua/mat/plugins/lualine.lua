return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    local custom_theme = require("lualine.themes.gruvbox")

    local kanagawa = require("mat.core.kanagawa")
    custom_theme = {
      normal = {
        a = { bg = kanagawa.sumiInk0, fg = kanagawa.lotusWhite0, gui = "bold" },
        b = { bg = kanagawa.sumiInk1, fg = kanagawa.lotusWhite1 },
        c = { bg = kanagawa.sumiInk2, fg = kanagawa.lotusWhite2 },
      },
      insert = {
        a = { bg = kanagawa.lotusBlue3, fg = kanagawa.dragonBlack2, gui = "bold" },
        b = { bg = kanagawa.lotusBlue4, fg = kanagawa.lotusWhite1 },
        c = { bg = kanagawa.sumiInk2, fg = kanagawa.lotusWhite2 },
      },
      visual = {
        a = { bg = kanagawa.oniViolet2, fg = kanagawa.dragonBlack2, gui = "bold" },
        b = { bg = kanagawa.oniViolet, fg = kanagawa.lotusWhite1 },
        c = { bg = kanagawa.sumiInk2, fg = kanagawa.lotusWhite2 },
      },
      replace = {
        a = { bg = kanagawa.peachRed, fg = kanagawa.dragonBlack2, gui = "bold" },
        b = { bg = kanagawa.lotusRed, fg = kanagawa.dragonBlack3 },
        c = { bg = kanagawa.sumiInk2, fg = kanagawa.lotusWhite2 },
      },
      command = {
        a = { bg = kanagawa.lotusOrange, fg = kanagawa.dragonBlack3, gui = "bold" },
        b = { bg = kanagawa.carpYellow, fg = kanagawa.dragonBlack3 },
        c = { bg = kanagawa.sumiInk2, fg = kanagawa.lotusWhite2 },
      },
      inactive = {
        a = { bg = kanagawa.ash, fg = kanagawa.lotusWhite2, gui = "bold" },
        b = { bg = kanagawa.ash, fg = kanagawa.lotusWhite2 },
        c = { bg = kanagawa.ash, fg = kanagawa.lotusWhite2 },
      },
    }

    lualine.setup({
      options = {
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        theme = custom_theme,
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
            path = 3,
          },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
