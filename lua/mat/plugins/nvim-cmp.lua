return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",                  -- source for text in buffer
    "hrsh7th/cmp-nvim-lsp-signature-help", -- source for signatures
    "hrsh7th/cmp-path",                    -- source for file system paths
    "L3MON4D3/LuaSnip",                    -- snippet engine
    "saadparwaiz1/cmp_luasnip",            -- for autocompletion
    "rafamadriz/friendly-snippets",        -- useful snippets
    "onsails/lspkind.nvim",                -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")

    local lspkind = require("lspkind")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<A-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<A-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<A-b>"] = cmp.mapping.scroll_docs(-4),
        ["<A-f>"] = cmp.mapping.scroll_docs(4),
        ["<A-e>"] = cmp.mapping.abort(), -- close completion window
        ["<A-l>"] = cmp.mapping.confirm({ select = true }),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" },  -- text within current buffer
        { name = "path" },    -- file system paths
      }),
      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })

    lspkind.init({
      mode = 'symbol_text',

      -- default symbol map
      -- can be either 'default' (requires nerd-fonts font) or
      -- 'codicons' for codicon preset (requires vscode-codicons font)
      --
      -- default: 'default'
      preset = 'codicons',

      -- override preset symbols
      --
      -- default: {}
      symbol_map = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
      },

    })
  end,
}
