-- Do lua filetype detection
vim.g.do_filetype_lua = 1

require('plugins')
require('settings')
require('options')
require('mappings')
require('autocmds')
require('conf/diagnostics')
require('conf.bufferline')
require('conf/toggleterm')
require('conf/lsp_config')
require('conf/null-ls')
require('conf/nvim-cmp')
require('conf/telescope')
require('conf/heirline')
require('conf/nvim-tree')
require('colorscheme')

-- prints colorgroup for the word under the cursor
vim.cmd([[command! What echo synIDattr(synID(line('.'), col('.'), 1), 'name')]])
