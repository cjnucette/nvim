local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
local servers = require('nvim-lsp-installer.servers')
local server = require('nvim-lsp-installer.server')
local path = require('nvim-lsp-installer.path')
local npm = require('nvim-lsp-installer.installers.npm')

local server_name = 'astro-ls'

-- if not configs.astrols then
  configs[server_name] = {
    default_config = {
      filetypes = { 'astro' },
      root_dir = lspconfig.util.root_pattern('astro.config.mjs', 'package.json'),
      init_options = {
        configuration = {
          astro = {},
        },
      },
      settings = {},
    },
  }
-- end

-- local root_dir = '/home/cjnucette/.config/nvim/lsp_servers/astro-ls'
local root_dir = server.get_server_root_path(server_name)

local homepage = 'https://github.com/withastro/language-tools'
local installer = npm.packages({ '@astrojs/language-server' })

local astro_ls = server.Server:new({
  name = server_name,
  root_dir = root_dir,
  homepage = homepage,
  installer = installer,
  default_options = {
    cmd = { path.concat({root_dir, 'node_modules', '.bin', 'astro-ls'}), '--stdio' },
  },
})

servers.register(astro_ls)
