vim.api.nvim_create_user_command("LspRestart", function(info)
  local valid = {}
  for _, name in ipairs(info.fargs) do
    if vim.lsp.config[name] == nil then
      vim.notify(("Invalid server name '%s'"):format(name), vim.log.levels.ERROR)
    else
      valid[#valid + 1] = name
      vim.lsp.enable(name, false)
    end
  end

  -- Re-enable after a short delay so the disabled clients have time to detach.
  local timer = assert(vim.uv.new_timer())
  timer:start(500, 0, function()
    timer:close()
    vim.schedule(function()
      for _, name in ipairs(valid) do
        vim.lsp.enable(name)
      end
    end)
  end)
end, {
  desc = "Restart the given client(s)",
  nargs = "+",
  complete = function()
    return vim.tbl_keys(vim.lsp.config)
  end,
})
