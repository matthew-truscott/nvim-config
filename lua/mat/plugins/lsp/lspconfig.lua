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
    local lsp = require("mat.core.lsp")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

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
      handlers = lsp.handlers,
      on_attach = lsp.on_attach,
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

    -- PYRIGHT config (works, currently set up without diagnostics to try
    -- and connect with mypy)
    -- lspconfig.pyright.setup({
    --   capabilities = capabilities,
    --   handlers = lsp.handlers,
    --   on_attach = lsp.on_attach,
    --   root_dir = lspconfig.util.root_pattern(".git"),
    -- })

    -- BASEDPYRIGHT config (works, currently set up without diagnostics to try
    -- and connect with mypy)
    lspconfig.basedpyright.setup({
      capabilities = capabilities,
      handlers = lsp.handlers,
      on_attach = lsp.on_attach,
      root_dir = lspconfig.util.root_pattern(".git"),
    })

    -- -- RUFF config
    -- lspconfig.ruff.setup({
    --   capabilities = capabilities,
    --   handlers = lsp.handlers,
    --   on_attach = lsp.on_attach_backup,
    -- })

    -- PYRIGHT config (works, currently set up without diagnostics to try
    -- and connect with mypy)
    -- lspconfig.pyright.setup({
    --   capabilities = capabilities,
    --   handlers = lsp.handlers_silent,
    --   on_attach = function(client, bufnr)
    --     lsp.on_attach(client, bufnr)
    --     client.server_capabilities.codeActionProvider = false
    --   end,
    --   settings = {
    --     pyright = {
    --       disableOrganizeImports = true,
    --     },
    --     python = {
    --       analysis = {
    --         autoSearchPaths = true,
    --         typeCheckingMode = "basic",
    --         useLibraryCodeForTypes = true,
    --       },
    --     },
    --   },
    -- })

    -- configure rust-analyzer server
    lspconfig.rust_analyzer.setup({
      handlers = lsp.handlers,
      on_attach = lsp.on_attach,
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
      handlers = lsp.handlers,
      on_attach = lsp.on_attach,
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
