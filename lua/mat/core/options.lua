local opt = vim.opt -- for conciseness
local o = vim.o

opt.guifont = { "Cascadia Code", ":h18" }

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true

-- line wrapping
opt.wrap = false -- disable line wrapping

-- folding
opt.foldenable = true
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

opt.conceallevel = 1

-- ruler
opt.colorcolumn = "120"
opt.scrolloff = 30

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = false -- highlight the current cursor line

-- clipboard
opt.clipboard:append("unnamedplus")

-- consider string-string as whole word
opt.iskeyword:append("-")

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
if os.getenv("theme") == "light" then
  opt.background = "light"
else
  opt.background = "dark" -- colorschemes that can be light or dark will be made dark
end
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- splits
opt.splitright = true
opt.splitbelow = true

-- custom symbols
opt.list = true
opt.listchars = {
  -- eol = "↵",
  trail = "~",
  nbsp = "␣",
  space = "·",
}

opt.pumheight = 10

o.winborder = "single"
