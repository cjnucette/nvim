local map = require('utils').map

local opts = {noremap = false}
map('n', '<leader>cc', '<Plug>ColorConvertCycle', opts)
map('n', '<leader>ch', '<Plug>ColorConvertHEX', opts)
map('n', '<leader>cr', '<Plug>ColorConvertRGB', opts)
map('n', '<leader>cs', '<Plug>ColorConvertHSL', opts)
