-- Prefer the project venv's pyright-langserver (this server is opted into
-- per-project via a `.nvim-pyright` marker, so it's typically installed there),
-- then fall back to anything on PATH.
local root = vim.fs.root(0, { "pyproject.toml", ".git" })
local venv = root and root .. "/.venv/bin/pyright-langserver"
local server = (venv and vim.uv.fs_stat(venv) and venv) or vim.fn.exepath("pyright-langserver")

----@type vim.lsp.Config
return {
  cmd = { server, "--stdio" },
  filetypes = { "python" },
  root_markers = {
    ".git",
    "pyproject.toml",
    "pyrightconfig.json",
  },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        autoImportCompletions = true,
        diagnosticMode = "workspace",
      },
    },
  },
}
