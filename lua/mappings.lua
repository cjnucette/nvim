local map = require('utils').map

-- leader and local leader
-- map("", "<Space>", "<Nop>") -- as in defaults.nvim. Why? I don't know yet ;p
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- key-menu conf
vim.o.timeoutlen = 300
require('key-menu').set('n', '<space>')

-- maps
map('n', '<leader>ev', '<cmd>e $MYVIMRC<cr>', { desc = 'Loads init.lua' })
map('n', '<leader>sv', '<cmd>source $MYVIMRC<cr>', { desc = 'Sources init.lua' })
map('n', '<leader>w', '<cmd>w!<cr>', { desc = 'Saves buffer' })
map('n', '<leader>q', '<cmd>q!<cr>', { desc = 'Quit nvim' })
map('n', '<leader>x', '<cmd>x!<cr>', { desc = 'Saves and quit nvim' })
map('n', '<leader><space>', 'za', { desc = 'Unfold all' })
map('v', '<leader><space>', 'za')
map('n', '<leader>u', 'vb~A', { desc = 'Change case of previous word' })
map('n', '<leader>cd', '<cmd>cd %:p:h<cr>', { desc = 'Change to the directory of the current file' })
map('n', '<leader>k', ':h <c-r><c-w><cr>', { desc = 'Gets help for the word under the cursor' })

-- Searches for the text last replaced and repeat the replace.
map('n', 'g.', [[/\V<C-r>"<CR>cgn<C-a><Esc>]], { desc = 'Searches for the text last replaced and repeat the replace' })

-- maximizertoggle
map('n', '<leader>m', '<cmd>MaximizerToggle<CR>', { desc = 'Maximizes / Un-maximizes current buffer' })

-- cycle buffers
map('n', '<tab>', '<cmd>bn<cr>')
map('n', '<s-tab>', '<cmd>bp<cr>')

-- aling block of text and keep them selected
map('v', '<', '<gv')
map('v', '>', '>gv')

-- reselect last pasted element
map('n', 'gp', '`[v`]')

-- toggle list
map('n', '<F5>', '<cmd>set list!<cr>')

-- up and down work as expected
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- move lines keeping indentation
map('n', '<c-j>', '<cmd>m .+1<cr>==')
map('n', '<c-k>', '<cmd>m .-2<cr>==')
map('v', '<c-j>', "<cmd>m '>+1<cr>gv=gv")
map('v', '<c-k>', "<cmd>m '<-2<cr>gv=gv")

-- checkout highlight group under the cursor
vim.cmd([[
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
]])
