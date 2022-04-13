M = {}

local prettier = {
  formatCommand = [[prettier --stdin-filepath ${INPUT} --config-precedence prefer-file --tab-width 2 --singleQuote --bracket-same-line --trailing-comma es5 --print-width 90]],
  formatStdin = true
}

M.languages = {
  html = {prettier},
  css = {prettier},
  markdown = {prettier},
  json = {prettier},
  javascript = {prettier},
  javascriptreact = {prettier},
  typescript = {prettier},
  typescriptreact = {prettier},
  astro = {prettier},
  nunjucks = {prettier},
}

return M
