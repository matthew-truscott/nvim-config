-- LSP activation (references lsp/<filename>)
-- Python typecheckers. By default both a pyright-family server and ty run:
--   a `.nvim-pyright` marker in the project root -> pyright, else basedpyright
-- ty joins it whenever the project venv has ty, rather than replacing it. They
-- do not check the same things, and a project can disable a rule in one that
-- the other still enforces -- artemis-backend sets `reportCallIssue = false`,
-- which leaves ty as the only checker reporting a call with missing or
-- unexpected arguments. Its CI runs the pair for that reason, so the editor
-- should too.
--
-- A project that has settled on ty alone is the exception: running basedpyright
-- there floods the buffer with diagnostics nobody intends to fix. Such a
-- project is recognised by its config -- ty configured (a `[tool.ty]` table in
-- pyproject.toml, or a ty.toml) with no pyright config anywhere (no
-- `[tool.pyright]`/`[tool.basedpyright]` table, no pyrightconfig.json) -- and
-- the pyright family is left off.
--
-- To opt a project into stock pyright, or to force the pyright family back on
-- in a project the ty-only rule would otherwise catch: `touch .nvim-pyright`.
local function root()
  return vim.fs.root(0, { "pyproject.toml", ".git" })
end

local function root_has(rel)
  local r = root()
  return r and vim.uv.fs_stat(r .. "/" .. rel) ~= nil
end

-- Read a root-relative file, or nil if it is not there.
local function root_read(rel)
  local r = root()
  if not r then
    return nil
  end
  local ok, lines = pcall(vim.fn.readfile, r .. "/" .. rel)
  return ok and table.concat(lines, "\n") or nil
end

-- Match a TOML table header at the start of a line, e.g. `[tool.ty]` or any
-- subtable of it (`[tool.ty.src]`). Table names may carry surrounding spaces.
local function has_table(toml, name)
  return toml:match("\n%s*%[%s*" .. name .. "%s*[%].]") ~= nil
end

-- Is this project configured for ty and nothing else?
local function ty_only()
  local pyproject = root_read("pyproject.toml") or ""
  -- readfile drops the leading newline has_table anchors on.
  pyproject = "\n" .. pyproject

  local pyright_configured = has_table(pyproject, "tool%.pyright")
    or has_table(pyproject, "tool%.basedpyright")
    or root_has("pyrightconfig.json")
  if pyright_configured then
    return false
  end

  return has_table(pyproject, "tool%.ty") or root_has("ty.toml") or root_has(".ty.toml")
end

local servers = {
  "lua_ls",
  "pytest_lsp",
  "ruff",
  "vtsls",
  "eslint",
  "rustanalyzer",
  "julials",
  "bash_ls",
}

local has_ty = root_has(".venv/bin/ty")
if has_ty then
  table.insert(servers, "ty")
end

-- The marker is the override, so it wins over the ty-only rule. Otherwise drop
-- the pyright family only when ty is actually going to run in its place; a
-- ty-only project without ty installed still needs *a* typechecker.
if root_has(".nvim-pyright") then
  table.insert(servers, "pyright")
elseif not (has_ty and ty_only()) then
  table.insert(servers, "basedpyright")
end

vim.lsp.enable(servers)

-- Pick one owner for goto-definition and friends.
--
-- Running ty next to the pyright family is what we want for diagnostics, but
-- both answer textDocument/definition, and Snacks fans the request out to every
-- attached client -- so `gd` offers the same location twice. Diagnostics,
-- completion and hover stay on both; only navigation gets an owner.
--
-- `vim.g.python_nav_server` names it: "ty" (default), "pyright" to hand
-- navigation back to the pyright family, or false to let both answer again.
if vim.g.python_nav_server == nil then
  vim.g.python_nav_server = "ty"
end

local NAV_CAPS = {
  "definitionProvider",
  "declarationProvider",
  "typeDefinitionProvider",
  "implementationProvider",
  "referencesProvider",
}

local PYRIGHT_FAMILY = { basedpyright = true, pyright = true }

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("PythonNavOwner", { clear = true }),
  callback = function(ev)
    local prefer = vim.g.python_nav_server
    if not prefer then
      return
    end

    local ty, pyright
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = ev.buf })) do
      if client.name == "ty" then
        ty = client
      elseif PYRIGHT_FAMILY[client.name] then
        pyright = client
      end
    end
    if not (ty and pyright) then
      return
    end

    local loser = prefer == "ty" and pyright or ty
    for _, cap in ipairs(NAV_CAPS) do
      loser.server_capabilities[cap] = nil
    end
  end,
  desc = "Let one Python server own goto-definition",
})

-- Give `gq`/`gw` back to the built-in formatter.
--
-- nvim's LSP defaults set 'formatexpr' to vim.lsp.formatexpr() whenever the
-- server advertises textDocument/rangeFormatting (ruff does), which routes
-- every `gq` through the server. That reformats code and leaves docstring
-- prose untouched -- the opposite of what `gq` is for. Nothing is lost:
-- format-on-save is conform, with lsp_fallback disabled.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspNoFormatexpr", { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].formatexpr = ""
  end,
  desc = "Keep gq/gw on the built-in formatter, not the LSP",
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
  virtual_text = false,
  virtual_lines = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})
