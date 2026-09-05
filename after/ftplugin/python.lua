-- Docstring reflow. `gw`/`gq` use the built-in formatter (see the LspAttach
-- hook in lua/mat/core/lsp.lua, which clears the LSP's 'formatexpr' so it does
-- not swallow the range), and these settings teach it how a docstring is laid
-- out: wrap at 88, and treat markdown bullets/numbers as list items so their
-- continuation lines hang under the text rather than under the marker.
--
-- 't' is removed so prose does not autowrap while typing -- reflowing is a
-- deliberate `gwip`, never a side effect of writing code. 'n' requires
-- 'autoindent' (set globally in core/options.lua); without it it does nothing.
vim.opt_local.textwidth = 88
vim.opt_local.formatoptions:remove("t")
vim.opt_local.formatoptions:append("qnj")

-- Default 'formatlistpat' matches numbered lists only, so `- foo` bullets get
-- reflowed into the preceding paragraph. Match both.
vim.opt_local.formatlistpat = [[^\s*\%(\d\+[.)]\|[-*+]\)\s\+]]
