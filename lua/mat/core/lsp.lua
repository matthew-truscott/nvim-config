-- LSP activation (references lsp/<filename>)
-- Use ty if available in the project venv, otherwise basedpyright
local function has_ty()
  local root = vim.fs.root(0, { "pyproject.toml" })
  return root and vim.uv.fs_stat(root .. "/.venv/bin/ty") ~= nil
end

local python_typechecker = has_ty() and "ty" or "basedpyright"

vim.lsp.enable({
  "lua_ls",
  python_typechecker,
  "ruff",
  "eslint",
  "rustanalyzer",
  "julials",
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
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
