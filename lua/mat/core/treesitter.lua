-- Native treesitter wiring (replaces the nvim-treesitter plugin).
--
-- Parsers are installed as *.so under ~/.local/share/nvim/site/parser. The
-- nvim-treesitter plugin used to (a) alias filetypes whose parser has a
-- different name and (b) start treesitter on every buffer. Native treesitter
-- does neither on its own, so we do both here. Without this, buffers get no
-- treesitter highlighting/folds and Comment.nvim's context commentstring
-- (JSX/Vue) has no tree to inspect.

-- Filetypes whose parser is named differently from the filetype itself.
-- vim.treesitter.language.register(parser_name, filetype).
vim.treesitter.language.register("tsx", "typescriptreact")
vim.treesitter.language.register("javascript", "javascriptreact")

local group = vim.api.nvim_create_augroup("NativeTreesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function(ev)
    -- pcall: filetypes without an installed parser (e.g. vue until its parser
    -- is installed) just fall back to regex syntax instead of erroring.
    pcall(vim.treesitter.start, ev.buf)
  end,
})
