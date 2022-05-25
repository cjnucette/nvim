local map = require('utils').map

map('n', '<leader>cc', '<Plug>ColorConvertCycle', { noremap = false, desc = 'Cycles through the different color formats' })
map('n', '<leader>ch', '<Plug>ColorConvertHEX', { noremap = false, desc = 'Change color format under the cursor to Hexadecimal' })
map('n', '<leader>cr', '<Plug>ColorConvertRGB', { noremap = false, desc = 'Change color format under the cursor to RGB' })
map('n', '<leader>cs', '<Plug>ColorConvertHSL', { noremap = false, desc = 'Change color format under the cursor to HSL' })
