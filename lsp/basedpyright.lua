----@type vim.lsp.Config
return {
  cmd = { vim.fn.exepath("basedpyright-langserver"), "--stdio" },
  filetypes = { "python" },
  root_markers = {
    ".git",
    "pyproject.toml",
    "pyrightconfig.json",
  },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
