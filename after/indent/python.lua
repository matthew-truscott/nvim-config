-- The runtime Python indenter (python#GetIndent) aligns continuation lines to
-- an unclosed "(" without knowing whether it is inside a string. That makes gw
-- mangle docstrings containing a stray paren. Return -1 (keep autoindent) when
-- the line is inside a string node, delegate to the real indenter otherwise.

local STRINGY = { string = true, string_content = true, concatenated_string = true }

local function in_string(lnum)
  local col = #vim.fn.getline(lnum):match("^%s*")
  local ok, node = pcall(vim.treesitter.get_node, { bufnr = 0, pos = { lnum - 1, col } })
  if not ok or not node then
    return false
  end
  while node do
    if STRINGY[node:type()] then
      return true
    end
    node = node:parent()
  end
  return false
end

function _G.MatPyIndent(lnum)
  if in_string(lnum) then
    return -1
  end
  return vim.fn["python#GetIndent"](lnum)
end

vim.bo.indentexpr = "v:lua.MatPyIndent(v:lnum)"
