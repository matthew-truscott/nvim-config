-- pytest fixture navigation. Runs alongside the python typechecker (see
-- mat/core/lsp.lua): pyright/basedpyright/ty deliberately have no plugin system
-- and cannot resolve pytest's name-based fixture injection, so goto-definition
-- and hover on a fixture parameter come from here instead.
---@type vim.lsp.Config
return {
  cmd = { vim.fn.exepath("pytest-language-server") },
  filetypes = { "python" },
  root_markers = {
    "pytest.ini",
    "pyproject.toml",
    "setup.cfg",
    "tox.ini",
    ".git",
  },
}
