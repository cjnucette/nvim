local util = require('lspconfig.util')
local configs = require('lspconfig.configs')
local servers = require('nvim-lsp-installer.servers')
local server = require('nvim-lsp-installer.server')
local path = require('nvim-lsp-installer.core.path')
local npm = require('nvim-lsp-installer.core.managers.npm')

local server_name = 'ls_emmet'

-- Adding configuration to lspconfig
if not configs.ls_emmet then
  configs.ls_emmet = {
    default_config = {
      cmd = { server_name, '--stdio' },
      filetypes = { 'html', 'css', 'scss' },
      root_dir = util.find_git_ancestor,
      single_file_support = true,
      settings = {}
    },
  }
end

local root_dir = vim.fn.stdpath('config') .. '/lsp_servers/' .. server_name

local ls_emmet = server.Server:new({
  name = server_name,
  root_dir = root_dir,
  installer = npm.packages({ 'ls_emmet' }),
  default_options = {
    -- cmd = { path.concat({ root_dir, 'node_modules', '.bin', 'ls_emmet' }), '--stdio' },
    cmd_env = npm.env(root_dir),
  },
})

servers.register(ls_emmet)
