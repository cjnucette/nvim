local formatter_ok, formatter = pcall(require, 'formatter')
if not formatter_ok then return end

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local prettier = function()
  local options = {
    exe = "prettier",
    args = {
      '--config-precedence',
      'prefer-file',
      '--stdin-filepath',
      vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
      '--single-quote',
      'true',
      '--bracket-same-line',
      'false',
      '--trailing-comma',
      'es5',
      '--print-width',
      '90',
    },
    stdin = true,
  }

  return options
end

local filetypes = {'html', 'css', 'markdown', 'json', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'astro', 'nunjucks'}

local filetype = {}
for _, ft in ipairs(filetypes) do
  filetype[ft] = {prettier}
end

formatter.setup({
  filetype = filetype
})

augroup('FormatterOnSave', {})
autocmd('BufWritePost', {
  group = 'FormatterOnSave',
  pattern = {'*.html', '*.css', '*.md', '*.json', '*.js', '*.jsx', '*.ts', '*.tsx', '*.astro', '*.njk'},
  command = 'FormatWrite'
})
