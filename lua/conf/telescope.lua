local telescope_ok, telescope = pcall(require, 'telescope')
if not telescope_ok then return end

local map = require('utils').map

-- settings
telescope.setup({
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
map('n', '<C-p>', '<cmd>lua require("conf/telescope").project_files()<cr>', { desc = 'Searches for files' })
map('n', '<leader>tb', '<cmd>Telescope buffers<CR>', { desc = 'Searches for buffers ' })
map('n', '<leader>tr', '<cmd>Telescope neoclip<CR>', { desc = 'Searches in clipboard' })
map('n', '<leader>th', '<cmd>Telescope help_tags<CR>', { desc = 'Searches in help' })
map('n', '<leader>tf', '<cmd>Telescope file_browser<CR>', { desc = 'Shows file explorer' })
map('n', '<leader>tg', '<cmd>Telescope live_grep<CR>', { desc = 'Shows matching greps results' })
map('n', '<leader>tp', '<cmd>Telescope projects<CR>', { desc = 'Searches for projects' })
map('n', '<leader>tn', '<cmd>lua require("conf/telescope").notes()<cr>', { desc = 'Searches within ~/notes' })
map('n', '<leader>tc', '<cmd>lua require("conf/telescope").nvim_config()<cr>', { desc = 'Searches within ~/.config/nvim' })

-- lsp and diagnostic mappings
map('n', 'gd', '<cmd>Telescope lsp_definition<cr>', { buffer = 0, desc = 'jumps to the definition for the word under the cursor' })
map('n', 'gT', '<cmd>Telescope lsp_type_definition<cr>', { buffer = 0, desc = 'Jumps to the type definition for the word under the cursor' })
map('n', 'gI', '<cmd>Telescope lsp_implementation<cr>', { buffer = 0, desc = 'Jumps to the implementation' })
map('n', '<leader>la', '<cmd>Telescope diagnostics<cr>', { buffer = 0, desc = 'Shows diagnostics in telescope' })

return M
