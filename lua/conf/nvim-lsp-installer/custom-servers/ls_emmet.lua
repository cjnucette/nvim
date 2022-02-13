local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
local servers = require('nvim-lsp-installer.servers')
local server = require('nvim-lsp-installer.server')
local path = require('nvim-lsp-installer.path')
local npm = require('nvim-lsp-installer.installers.npm')

local server_name = 'ls_emmet'

if not configs.ls_emmet then
  configs.ls_emmet = {
    default_config = {
      filetypes = { 'html', 'css', 'scss', 'sass', 'javascriptreact', 'typescriptreact' },
      root_dir = function()
        return vim.loop.cwd()
      end,
      settings = {},
    },
  }
end

local root_dir = server.get_server_root_path(server_name)

local installer = npm.packages({ 'ls_emmet' })

local ls_emmet = server.Server:new({
  name = server_name,
  root_dir = root_dir,
  installer = installer,
  default_options = {
    cmd = { path.concat({root_dir, 'node_modules', '.bin', 'ls_emmet'}), '--stdio' },
  },
})

servers.register(ls_emmet)
