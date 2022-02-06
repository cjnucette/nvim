local map = require('utils').map

-- leader and local leader
-- map("", "<Space>", "<Nop>") -- as in defaults.nvim. Why? I don't know yet ;p
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- maps
map('n', '<leader>ev', '<cmd>e $MYVIMRC<cr>')
map('n', '<leader>sv', '<cmd>source $MYVIMRC<cr>')
map('n', '<leader>w', '<cmd>w!<cr>')
map('n', '<leader>q', '<cmd>q!<cr>')
map('n', '<leader>x', '<cmd>x!<cr>')
map('n', '<leader><space>', 'za')
map('v', '<leader><space>', 'za')
map('n', '<leader>u', 'vb~A')

--various searches
map('n', '<leader>gh', "<cmd>h <c-r>=expand('<cword>')<cr><cr>")
map('n', '<leader>*', '<cmd>grep -R <cword> * --exclude-dir={node_modules,.git}<cr><cr>')
map('n', '<leader>gr', "<cmd>CocSearch <c-r>=expand('<cword>')<cr><cr>")
map('n', '<leader>gg', "<cmd>Rg <c-r>=expand('<cword>')<cr><cr>")

-- Searches for the text last replaced and repeat the replace.
map('n', 'g.', [[/\V<C-r>"<CR>cgn<C-a><Esc>]])

-- maximizertoggle
map('n', '<leader>m', '<cmd>MaximizerToggle<CR>')

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
-- map('n',
-- "<F10>",
-- [[:echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>]],
-- opts)
