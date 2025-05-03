DARKER_AVAILABLE = nil

function CheckDarkerAvailability()
  if DARKER_AVAILABLE ~= nil then
    return DARKER_AVAILABLE
  end

  local exit_code = os.execute("darker --version > /dev/null 2>&1")
  DARKER_AVAILABLE = (exit_code == 0)
  return DARKER_AVAILABLE
end

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        python = function()
          if CheckDarkerAvailability() then
            return { "darker" }
          else
            return { "isort", "black" }
          end
        end,
        rust = { "rustfmt" },
        lua = { "stylua" },
        csharp = { "csharpier" },
        json = { "jq" },
        vue = { "prettier" },
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
