-- set leader key to space
vim.g.mapleader = " "

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to the left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to the bottom window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to the top window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to the right window", remap = true })

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save", silent = true })
vim.keymap.set("n", "<leader>q", ":wqa<CR>", { desc = "Save and Quit", silent = true })

-- <leader>bd (delete buffer) is mapped in plugins/snacks.lua via Snacks.bufdelete().

-- Copy relative file path
vim.keymap.set('n', '<leader>cf', function()
  local path = vim.fn.expand('%:.')
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path, vim.log.levels.INFO)
end, { desc = 'Copy relative path' })

-- indent while remaining in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- clear highlighting
vim.keymap.set("n", "<leader>no", ":noh<CR>", { desc = "Clear Highlighting", silent = true })

-- When lines are on, text is off. Text on, lines off. Minimize clutter.
vim.keymap.set("n", "<leader>bl", function()
  vim.diagnostic.config({
    virtual_lines = not vim.diagnostic.config().virtual_lines,
  })
end, { desc = "Toggle diagnostic [l]ines" })

vim.keymap.set("n", "gl", function()
  vim.diagnostic.open_float()
end, { desc = "Show diagnostic under cursor" })

vim.keymap.set("n", "<leader>bh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay [h]ints" })
