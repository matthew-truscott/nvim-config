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

  -- set keybinds
  opts.desc = "See available code actions"
  keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions

  opts.desc = "Smart rename"
  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

  opts.desc = "Show line diagnostics"
  keymap.set("n", "gl", vim.diagnostic.open_float, opts) -- show diagnostics for line

  opts.desc = "Go to previous diagnostic"
  keymap.set("n", "[d", vim.diagnostic.get_prev, opts) -- jump to previous diagnostic in buffer

  opts.desc = "Go to next diagnostic"
  keymap.set("n", "]d", vim.diagnostic.get_next, opts) -- jump to next diagnostic in buffer

  opts.desc = "Show documentation for what is under cursor"
  keymap.set("n", "K", vim.lsp.buf.hover, opts) -- hover
end

return M
