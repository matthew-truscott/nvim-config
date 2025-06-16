require("mat.core.keymaps")
require("mat.core.options")
require("mat.core.lsp")

if vim.env.ZELLIJ ~= nil then
  vim.fn.system({ "zellij", "action", "switch-mode", "locked" })
end

vim.g.python3_host_prog = "/home/matthew.t/app/neovim-py/.venv/bin/python"
