-- set leader key to space
vim.g.mapleader = " "

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to the left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to the bottom window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to the top window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to the right window", remap = true })

-- indent while remaining in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
