-- lsp/eslint.lua
return {
  cmd = { vim.fn.exepath("eslint") },
  filetypes = { "typescript" },
  settings = {
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine",
      },
      showDocumentation = {
        enable = false, -- <-- this, doesn't apply
      },
    },
    codeActionOnSave = {
      enable = false, -- <-- this either
      mode = "all",
    },
    format = false,
    quiet = true,
    run = "onSave",
  },
  flags = {
    allow_incremental_sync = false,
    debounce_text_changes = 1000,
  },
}
