local nvimtree_ok, nvimtree = pcall(require,'nvim-tree')
if not nvimtree_ok then return end

local map = require('utils').map
local signs = require('utils').signs
local tree_cb = require('nvim-tree.config').nvim_tree_callback

local list = {
  { key = 'l', cb = tree_cb('edit') },
  { key = 'h', cb = tree_cb('close_node') },
}

-- g options
-- vim.g.nvim_tree_quit_on_open = 1 -- close tree after choosing a file
vim.g.nvim_tree_indent_markers = 1

-- setup
nvimtree.setup({
  auto_close = true, -- quit nvim if nvimtree is the last buffer.
  update_cwd = true,
  open_on_setup = true,
  disable_netrw        = false,
  hijack_netrw         = true,
  hijack_directories   = {
    enable = true,
    auto_open = true,
  },
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
  actions = {
    open_file = {
      quit_on_open = true, -- close nvimtree when selecting a file.
    }
  }
})

-- mappings
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>')
map('n', '<leader>en', '<cmd>NvimTreeFindFile<CR>')
