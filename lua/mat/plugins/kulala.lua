return {
  "mistweaverco/kulala.nvim",
  keys = {
    {
      "<leader>rs",
      function()
        require("kulala").run()
      end,
      desc = "Send request",
    },
    {
      "<leader>ra",
      function()
        require("kulala").run_all()
      end,
      desc = "Send all requests",
    },
    {
      "<leader>rb",
      function()
        require("kulala").scratchpad()
      end,
      desc = "Open scratchpad",
    },
    {
      "<leader>re",
      function()
        require("kulala").set_selected_env()
      end,
      desc = "Select environment",
    },
  },
  ft = { "http", "rest" },
  opts = {
    global_keymaps = false,
    global_keymaps_prefix = "<leader>r",
    kulala_keymaps_prefix = "",
    -- Restore contenttypes defaults dropped upstream in v6.10.1 (commit 8efd731),
    -- which broke JSONPath resolution for request variables like
    -- {{login.response.body.$.access_token}}. Remove once fixed upstream.
    contenttypes = {
      ["application/json"] = {
        ft = "json",
        pathresolver = function(...)
          return require("kulala.parser.jsonpath").parse(...)
        end,
      },
      ["application/graphql"] = { ft = "graphql", pathresolver = nil },
      ["application/javascript"] = { ft = "javascript", pathresolver = nil },
      ["application/lua"] = { ft = "lua", pathresolver = nil },
      ["application/graphql-response+json"] = "application/json",
      ["application/xml"] = {
        ft = "xml",
        pathresolver = vim.fn.executable("xmllint") == 1 and { "xmllint", "--xpath", "{{path}}", "-" },
      },
      ["text/html"] = { ft = "html", pathresolver = nil },
    },
    ui = {
      split_direction = "horizontal",
      max_response_size = 524000,
      win_opts = {
        wo = { wrap = true },
      },
    },
  },
}
