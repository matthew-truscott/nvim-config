return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    local opts = {
      noremap = true,
      silent = true,
    }

    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definitions, references

      opts.desc = "Go to declaration"
      keymap.set("n", "gd", vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gD", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp type definitions

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "gL", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show diagnostics for file

      opts.desc = "Show line diagnostics"
      keymap.set("n", "gl", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- hover
    end

    -- Used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local border = {
      { "╭", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╮", "FloatBorder" },
      { "│", "FloatBorder" },
      { "╯", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╰", "FloatBorder" },
      { "│", "FloatBorder" },
    }

    -- LSP settings (for overriding per client)
    -- To use, add this to the client (currently ignored)
    -- e.g. lspconfig._client_.setup({handlers=handlers})
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    }

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- configure lua server (with special settings)
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    lspconfig.pyright.setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = on_attach,
    })

    lspconfig.tsserver.setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = on_attach,
    })

    -- configure rust-analyzer server
    lspconfig.rust_analyzer.setup({
      on_attach = on_attach,
      handlers = handlers,
      settings = {
        ["rust-analyzer"] = {
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,
          },
        },
      },
    })

    lspconfig.clangd.setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = on_attach,
    })

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#omnisharp
    lspconfig.omnisharp.setup({
      cmd = { "dotnet", "/usr/bin/omnisharp" },

      -- Settings from .editorconfig
      enable_editorconfig_support = true,

      enable_ms_build_load_projects_on_demand = false,

      enable_roslyn_analyzers = false,

      organize_imports_on_format = true,

      enable_import_completion = false,

      sdk_include_prereleases = true,

      analyze_open_documents_only = false,
    })
  end,
}
