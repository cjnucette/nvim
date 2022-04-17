-- Abbreviations
local cmd = vim.cmd
local set = vim.opt
local hi = vim.api.nvim_set_hl
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

-- Relevant options
set.termguicolors = true
set.background = 'dark'

function MyHighlights()
  local bg = require('utils').get_color('Normal', 'bg#')
  -- cmd([[hi EndOfBuffer guifg=bg]])
  hi(0, 'EndOfBuffer', { fg = bg })
  -- palenight fix; otherwise remove it or change it accordingly
  -- hi(0, 'Pmenu', { bg = '#202331'})
  -- hi(0, 'PmenuSel', { bg = '#202331'})
  if vim.fn.exists('+pumblend') then
    cmd([[hi PmenuSel blend=0]])
    -- hi(0, 'PmenuSel', { blend = 0 })
  end
end

-- Autocommads
local mycolor = augroup('MyColor', { clear = true })
autocmd('ColorScheme', { group = mycolor, callback = function() MyHighlights() end })

-- Commands
command('What', 'TSHighlightCapturesUnderCursor', { desc = 'Display color group of the word under the cursor' })


-- Set colorscheme

-- theme styles: oceanic | deep ocean | palenight | lighter | darker
vim.g.material_italic_comments = true
vim.g.material_italic_keywords = true
vim.g.material_italic_functions = true
vim.g.material_style = 'palenight'
cmd([[colorscheme material]])

-- vim.g.onedark_hide_endofbuffer=1
-- vim.g.onedark_terminal_italics=1
-- colorscheme onedark

-- vim.g.oceanic_bold=1
-- vim.g.oceanic_italic_comments=1
-- colorscheme oceanicnext
--
-- themes: nightfox | palefox | nordfox
-- vim.g.nightfox_style = "nordfox"
-- vim.g.nightfox_italic_comments = 1
-- vim.g.nightfox_italic_functions = 1
-- cmd([[colorscheme nightfox]])

-- theme styles: night | day | storm
-- vim.g.tokyonight_style = 'night'
-- vim.g.tokyonight_italic_comments = true
-- cmd([[colorscheme tokyonight]])

-- vim.g.nord_contrast = true
-- vim.g.nord_borders = true
-- cmd([[colorscheme nord]])

-- cmd([[colorscheme dracula]])
