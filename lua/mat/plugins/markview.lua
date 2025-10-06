-- For `plugins/markview.lua` users.
return {
  "OXY2DEV/markview.nvim",
  lazy = false,

  -- For `nvim-treesitter` users.
  priority = 49,

  config = function()
    require("markview").setup({

      preview = {
        modes = { "n", "no", "c" },
        hybrid_modes = { "n" },

        callbacks = {
          on_enable = function(_, win)
            vim.wo[win].conceallevel = 2
            vim.wo[win].concealcursor = "nc"
          end,
        },
      },

      latex = {
        enable = true,
        filetypes = { "markdown", "quarto", "rmd" },

        parenthesis = {
          enable = true,

          ---@type string
          hl = "@punctuation.brackets",
        },

        blocks = {
          enable = true,

          ---@type string
          hl = "Code",

          ---@type string[]
          text = { " LaTeX ", "Special" },
        },

        inlines = {
          enable = true,
        },

        subscripts = {
          enable = true,
        },

        superscripts = {
          enable = true,
        },

        symbols = {
          enable = true,
        },
      },
    })
  end,
}
