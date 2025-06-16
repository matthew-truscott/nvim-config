----@type vim.lsp.Config
return {
  cmd = { vim.fn.exepath("ruff"), "server" },
  on_attach = function(client, _)
    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end
  end,
  root_markers = { "pyproject.toml" },
  filetypes = { "python" },
}
