local null_ls_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_ok then
  return
end

local prettier_conf = function()
  local options = {}

  if
    vim.fn.filereadable('./.prettierrc') == 0
    and vim.fn.filereadable('./.prettierrc.js') == 0
    and vim.fn.filereadable('./.prettierrc.cjs') == 0
    and vim.fn.filereadable('./.prettierrc.json') == 0
    and vim.fn.filereadable('./.prettier.config.js') == 0
    and vim.fn.filereadable('./.prettier.config.cjs') == 0
    and (
      vim.fn.filereadable('./package.json') == 1
      and vim.fn.match(vim.fn.readfile('./package.json'), '"prettier": {') == -1
    )
  then
    options.extra_args = {
      '--single-quote',
      'true',
      '--bracket-same-line',
      'false',
      '--trailing-comma',
      'es5',
      '--print-width',
      '90',
    }
  end

  return options
end

null_ls.setup({
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
      augroup format_on_save
        autocmd!
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
   ]])
    end
  end,
  sources = {
    null_ls.builtins.formatting.stylua.with({
      extra_args = { '-', '--indent-width', '2', '--indent-type', 'Spaces', '--quote-style', 'autoPreferSingle' },
    }),
    null_ls.builtins.formatting.prettier.with(prettier_conf()),
  },
})
