local null_ls_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_ok then
  return
end

local is_cfg_present = function(cfg_filename)
  return vim.fn.filereadable(vim.fn.expand(cfg_filename)) == 1
end

local is_using_prettierrc = function()
  return is_cfg_present('./.prettierrc')
    or is_cfg_present('./.prettierrc.js')
    or is_cfg_present('./.prettierrc.cjs')
    or is_cfg_present('./.prettierrc.json')
    or is_cfg_present('./.prettier.config.js')
    or is_cfg_present('./.prettier.config.cjs')
    or (is_cfg_present('./package.json') and vim.fn.match(vim.fn.readfile('./package.json'), '"prettier": {') == 1)
end

local prettier_conf = function()
  local options = {
    disabled_filetypes = {'html'},
    condition = function(utils)
      return not utils.root_has_file({'deno.json', 'deno.jsonc'})
    end
  }

  if not is_using_prettierrc() then
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
    -- null_ls.builtins.formatting.stylua.with({
    --   extra_args = { '-', '--indent-width', '2', '--indent-type', 'Spaces', '--quote-style', 'autoPreferSingle' },
    -- }),
    null_ls.builtins.formatting.prettier.with(prettier_conf()),
  },
})
