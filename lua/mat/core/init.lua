require("mat.core.keymaps")
require("mat.core.options")
require("mat.core.treesitter")
require("mat.core.lsp")
require("mat.core.autocmds")
require("mat.core.commands")

if vim.env.ZELLIJ ~= nil then
  vim.fn.system({ "zellij", "action", "switch-mode", "locked" })
end

-- No Python remote plugins (rplugin) are used, so the python3 provider isn't
-- needed. The old neovim-py venv it pointed at was removed. Disable it so
-- :checkhealth stops erroring on the missing interpreter. To use a Python
-- plugin later, drop this line and set g:python3_host_prog to a venv with pynvim.
vim.g.loaded_python3_provider = 0
