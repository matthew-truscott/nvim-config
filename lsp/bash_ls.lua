---@type vim.lsp.Config
-- bash-language-server: hover docs for bash builtins/keywords (from man pages)
-- and shellcheck code explanations. Install: npm i -g bash-language-server
-- Richer diagnostics + hover explanations if shellcheck is on PATH.
return {
  cmd = { vim.fn.exepath("bash-language-server"), "start" },
  filetypes = { "bash", "sh" },
  root_markers = { ".git" },
}
