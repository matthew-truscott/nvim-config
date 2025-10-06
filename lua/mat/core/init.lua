require("mat.core.keymaps")
require("mat.core.options")
require("mat.core.lsp")
require("mat.core.autocmds")
require("mat.core.commands")

if vim.env.ZELLIJ ~= nil then
  vim.fn.system({ "zellij", "action", "switch-mode", "locked" })
end

vim.g.python3_host_prog = "/home/matthew.t/app/neovim-py/.venv/bin/python"
