local map = require('utils').map

-- settings
require('telescope').setup({
  defaults = {
    layout_config = {
      prompt_position = 'top',
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case'
    },
  },
})

-- extensions
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('projects')
-- require('telescope').load_extension('coc')
-- require('telescope').load_extension('neoclip')
-- require('telescope').load_extension('bookmarks')

-- custom pickers
local M = {}

function M.project_files()
  local opts = {}
  local ok = pcall(require('telescope.builtin').git_files, opts)
  if not ok then
    require('telescope.builtin').find_files(opts)
  end
end

function M.notes()
  local opts = {
    prompt_title = ' Find Notes ',
    path_display = { 'shorten' },
    cwd = '~/notes',
  }
  require('telescope.builtin').find_files(opts)
end

function M.nvim_config()
  local opts = {
    prompt_title = ' Nvim ',
    path_display = { 'shorten' },
    cwd = '~/.config/nvim',
  }
  require('telescope.builtin').find_files(opts)
end

-- mappings
map('n', '<C-p>', '<cmd>lua require("conf/telescope").project_files()<cr>')
map('n', '<leader>tb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>tr', '<cmd>Telescope neoclip<CR>')
map('n', '<leader>th', '<cmd>Telescope help_tags<CR>')
map('n', '<leader>tf', '<cmd>Telescope file_browser<CR>')
map('n', '<leader>tg', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>tp', '<cmd>Telescope projects<CR>')
map('n', '<leader>tn', '<cmd>lua require("conf/telescope").notes()<cr>')
map('n', '<leader>tc', '<cmd>lua require("conf/telescope").nvim_config()<cr>')

return M
