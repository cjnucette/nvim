local map = vim.keymap.set
local opts = { silent = true, noremap = true }

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
--    bookmarks = {
--      selected_browser = 'google_chrome',
--      url_open_command = 'xdg-open',
--    },
  },
})

-- mappings
map('n', '<C-p>', ':lua require("conf/telescope").project_files()<CR>', opts)
map('n', '<leader>tb', '<cmd>Telescope buffers<CR>', opts)
map('n', '<leader>tr', '<cmd>Telescope neoclip<CR>', opts)
map('n', '<leader>th', '<cmd>Telescope help_tags<CR>', opts)
map('n', '<leader>te', '<cmd>Telescope file_browser<CR>', opts)
map('n', '<leader>tg', '<cmd>Telescope live_grep<CR>', opts)
map('n', '<leader>tn', '<cmd>lua require("conf/telescope").notes()<CR>', opts)
map('n', '<leader>tf', '<cmd>lua require("conf/telescope").file_explorer()<CR>', opts)
map('n', '<leader>tc', '<cmd>lua require("conf/telescope").nvim_config()<CR>', opts)

-- extensions
require('telescope').load_extension('fzf')
-- require('telescope').load_extension('projects')
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

function M.file_explorer()
  require('telescope.builtin').file_browser({
    prompt_title = ' File Explorer ',
    path_display = { 'shorten' },
    cwd = '~',
  })
end

return M
