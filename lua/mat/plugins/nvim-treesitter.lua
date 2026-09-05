-- Native treesitter setup.
--
-- Highlighting is done natively: lua/mat/core/treesitter.lua calls
-- vim.treesitter.start() on FileType. This plugin is used *only* as a parser
-- and query installer. We track the `main` branch (the Neovim 0.11+ rewrite,
-- NOT the deprecated `master` branch that ran its own highlight module): it
-- ships the highlights/injections/folds queries on the runtimepath and manages
-- the compiled parsers under stdpath("data")/site/parser -- the same directory
-- the parsers were previously hand-installed into.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- load at startup so queries are on the rtp before the first FileType
  build = ":TSUpdate",
  config = function()
    local langs = {
      -- editor / config
      "lua", "luadoc", "vim", "vimdoc", "query", "bash", "regex", "diff",
      -- data / config formats (the json parser also covers jsonc)
      "json", "yaml", "toml",
      -- docs
      "markdown", "markdown_inline", "latex",
      -- web
      "html", "css", "scss", "javascript", "typescript", "tsx", "vue",
      -- languages
      "python", "rust", "julia",
      -- git
      "gitignore", "gitcommit", "git_rebase",
    }
    -- install() is async and skips parsers that are already present.
    -- (kulala manages its own `http`/`kulala_http` parser, so it's not listed.)
    require("nvim-treesitter").install(langs)
  end,
}
