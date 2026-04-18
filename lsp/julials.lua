return {
  cmd = { "julia", "--startup-file=no", "--history-file=no", "-e", [[
    using LanguageServer
    runserver()
  ]] },
  filetypes = { "julia" },
}
