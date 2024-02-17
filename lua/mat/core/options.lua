local opt = vim.opt -- for conciseness

-- fonts (neovide)
opt.guifont = "JetBrainsMono Nerd Font Mono:h18"

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true         -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2       -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2    -- 2 spaces for indent width
opt.expandtab = true  -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true

-- line wrapping
opt.wrap = false -- disable line wrapping

-- ruler
opt.colorcolumn = "120"

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- clipboard
opt.clipboard:append("unnamedplus")

-- consider string-string as whole word
opt.iskeyword:append("-")

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift

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
