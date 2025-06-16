local M = {}

local keymap = vim.keymap -- for conciseness

local opts = {
  noremap = true,
  silent = true,
}

M.handlers = {}
M.handlers_silent = {}
for key, value in pairs(M.handlers) do
  M.handlers_silent[key] = value
end
M.handlers_silent["textDocument/publishDiagnostics"] = function() end

function M.on_attach_backup(client, bufnr)
  opts.buffer = bufnr
  client.server_capabilities.hoverProvider = false
end

function M.on_attach(_, bufnr)
  opts.buffer = bufnr

  vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
      vim.lsp.buf.clear_references()
    end,
    buffer = bufnr,
  })
end

-- LSP activation (references lsp/<filename>
vim.lsp.enable({
  "luals",
  "basedpyright",
  "ruff",
})
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
  virtual_text = false,
  virtual_lines = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})

return M
