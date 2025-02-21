-- /home/stevearc/.config/nvim/lua/overseer/template/user/cpp_build.lua
return {
  name = "Run API script",
  builder = function()
    -- Full path to current file (see :help expand())
    return {
      cmd = { "python", "falcon_optimisation_api/rest_api/run_api.py" },
      cwd = os.getenv("HOME") .. "/dev/api/falcon",
      components = { "on_output_quickfix" },
    }
  end,
  condition = {
    -- Check if the current working directory is the project directory
    cwd = os.getenv("HOME") .. "/dev/api/falcon",
    filetype = "python",
  },
}
