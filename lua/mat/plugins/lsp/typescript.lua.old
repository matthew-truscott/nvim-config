return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
  config = function()
    local lsp = require("mat.core.lsp")
    local ts = require("typescript-tools")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    ts.setup({
      capabilities = capabilities,
      handlers = lsp.handlers,
      on_attach = function(client, bufnr)
        lsp.on_attach(client, bufnr)
      end,
    })
  end,
}
