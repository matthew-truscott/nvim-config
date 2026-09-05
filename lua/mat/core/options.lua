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
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99

opt.conceallevel = 2

-- ruler
opt.colorcolumn = "120"
opt.scrolloff = 30

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = false -- highlight the current cursor line

-- Colour the cursor from the theme's Cursor group instead of the terminal
-- default. The default guicursor attaches no highlight, so nvim reset the
-- cursor to ghostty's default (hard to see on dark). Attaching Cursor/lCursor
-- makes nvim set it explicitly (fujiWhite in wave / lotusInk in lotus), and it
-- follows a light/dark flip since kanagawa reloads Cursor.
opt.guicursor = table.concat({
  "n-v-c-sm:block-Cursor/lCursor",
  "i-ci-ve:ver25-Cursor/lCursor",
  "r-cr-o:hor20-Cursor/lCursor",
  "t:block-blinkon500-blinkoff500-TermCursor",
}, ",")

-- clipboard
opt.clipboard:append("unnamedplus")

-- consider string-string as whole word
opt.iskeyword:append("-")

-- appearance
--
-- Do NOT force 'background' here. Neovim's TUI queries the terminal background
-- (OSC 11) at startup and subscribes to DEC mode 2031, so it flips 'background'
-- live when the terminal reports a system light/dark switch (ghostty follows
-- org.freedesktop.appearance). Setting it manually would fight that.
-- Fallback for terminals that can't be queried (bare TTY, tmux w/o passthrough):
if vim.env.TERM_BG == "light" or vim.env.theme == "light" then
  opt.background = "light"
end
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- auto-reload files when changed externally
opt.autoread = true
opt.updatetime = 250

-- splits
opt.splitright = true
opt.splitbelow = true

-- custom symbols
opt.list = true
opt.listchars = {
  -- eol = "↵",
  trail = "~",
  nbsp = "␣",
  tab = "  ", -- render tabs as plain indentation, not ^I
}

opt.pumheight = 10

o.winborder = "single"
