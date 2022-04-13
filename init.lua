-- Do lua filetype detection
vim.g.do_filetype_lua = 1

require('plugins')
require('settings')
require('options')
require('mappings')
require('autocmds')
require('globals')
require('conf/nvim-treesitter')
require('conf/nvim-lsp-installer')
require('conf/diagnostics')
require('conf/bufferline')
require('conf/toggleterm')
require('conf/nvim-cmp')
require('conf/telescope')
require('conf/heirline')
require('conf/indent-blankline')
require('conf/package-info')
require('conf/gitsigns')
require('conf/color-converter')
require('conf/neo-tree')
require('conf/project')
require('conf/emmet')
require('live_server')
require('colorscheme')
