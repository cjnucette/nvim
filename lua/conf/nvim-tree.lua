local nvimtree = require('nvim-tree')
local map = require('utils').map
local signs = require('utils').signs
local tree_cb = require('nvim-tree.config').nvim_tree_callback

local list = {
  { key = 'l', cb = tree_cb('edit') },
  { key = 'h', cb = tree_cb('close_node') },
}

-- g options
vim.g.nvim_tree_quit_on_open = 1 -- close tree after choosing a file
vim.g.nvim_tree_indent_markers = 1

-- setup
nvimtree.setup({
  auto_close = true, -- quit nvim if tree is the last buffer
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = signs.hint,
      info = signs.information,
      warning = signs.warning,
      error = signs.error,
    },
  },
  view = {
    width = 30,
    mappings = {
      list = list,
    },
  },
})

-- mappings
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>')
map('n', '<leader>en', '<cmd>NvimTreeFindFile<CR>')
