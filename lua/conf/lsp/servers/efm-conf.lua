M = {}

local prettier_cmd = vim.trim(vim.fn.system('[ $(command -v node_modules/.bin/prettier) ] && echo "node_modules/.bin/prettier" || echo "prettier"'))
local prettier = {
  formatCommand = prettier_cmd .. [[ --stdin-filepath ${INPUT} --config-precedence prefer-file --tab-width 2 --single-quote --bracket-same-line --trailing-comma es5 --print-width 90]],
  formatStdin = true
}

local vint = {
  lintCommand = 'vint -',
  lintStdin = true,
  lintFormats = { '%f:%l:%c: %m' },
  lintSource = 'vint'
}

local eslint = {
  lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    '%f(%l,%c): %tarning %m',
    '%f(%l,%c): %trror %m',
  },
  listSource = 'eslint'
}

local shellcheck = {
  lintCommand = 'shellcheck -f gcc -x -',
  lintStdin = true,
  lintFormats = {
    '%f:%l:%c: %trror: %m',
    '%f:%l:%c: %tarning: %m',
    '%f:%l:%c: %tote: %m',
  },
  lintSource = 'shellcheck',
}

local shfmt = {
  formatCommand = 'shfmt -i 2 -ci -bn'
}

M.languages = {
  -- html = { prettier },
  css = { prettier },
  markdown = { prettier },
  json = { prettier },
  javascript = { prettier },
  javascriptreact = { prettier },
  typescript = { prettier },
  typescriptreact = { prettier },
  astro = { prettier },
  vim = { vint },
  sh = { shellcheck, shfmt }
}

return M
