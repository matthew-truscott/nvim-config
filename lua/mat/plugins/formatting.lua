return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        python = { "ruff_format", "ruff_fix" },
        rust = { "rustfmt" },
        lua = { "stylua" },
        csharp = { "csharpier" },
        json = { "jq" },
        vue = { "prettier" },
        typescript = { "prettierd" },
        typescript_react = { "prettierd" },
        javascript = { "prettierd" },
        javascript_react = { "prettierd" },
        markdown = { "prettier" },
        -- yaml = { "yamlfmt" },
        -- toml = { "pyproject-fmt" },
      },
      format_on_save = {
        lsp_fallback = false,
        async = false,
        timeout_ms = 500,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
