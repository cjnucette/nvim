local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then return end

local lsp_installer_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not lsp_installer_ok then return end

local servers = {
  'sumneko_lua',
  'tsserver',
  -- 'emmet_ls',
  'bashls',
  'html',
  'cssls',
  'denols',
  'dockerls',
  'efm',
  'eslint',
  'gopls',
  'jsonls',
  'ltex',
  'rust_analyzer',
  'svelte',
  'taplo',
  'vimls',
  'yamlls',
}

-- local ensure_installed = vim.tbl_filter(function(d) return d ~= '' end, servers)

lsp_installer.setup({
  ensure_installed = servers,
  install_root_dir = vim.fn.stdpath('config') .. '/lsp_servers',
})

for _, server in pairs(servers) do
  local handlers = require('conf/lsp/handlers')
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
    handlers = handlers.handlers,
  }
  local has_custom_opts, server_custom_opts = pcall(require, 'conf/lsp/servers/' .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend('force', server_custom_opts, opts)
  end
  lspconfig[server].setup(opts)
end
