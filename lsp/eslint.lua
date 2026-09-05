-- lsp/eslint.lua
---@type vim.lsp.Config
return {
  cmd = { vim.fn.exepath("vscode-eslint-language-server"), "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.json",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "package.json",
    ".git",
  },
  -- The eslint server expects a `workspaceFolder` resolved at attach time.
  before_init = function(_, config)
    local root = config.root_dir or vim.fn.getcwd()
    config.settings = config.settings or {}
    config.settings.workspaceFolder = {
      uri = vim.uri_from_fname(root),
      name = vim.fn.fnamemodify(root, ":t"),
    }
  end,
  settings = {
    validate = "on",
    useESLintClass = true,
    experimental = { useFlatConfig = false },
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine",
      },
      showDocumentation = { enable = true },
    },
    codeActionOnSave = {
      enable = false,
      mode = "all",
    },
    format = false,
    quiet = true,
    run = "onSave",
    nodePath = "",
    problems = { shortenToSingleLine = false },
    workingDirectory = { mode = "location" },
  },
}
