local saga_ok, saga = pcall(require, 'lspsaga')
if not saga_ok then return end

local signs = require('utils').signs
local map = require('utils').map

saga.setup({
  error_sign = signs.error,
  warn_sign = signs.warning,
  hint_sign = signs.hint,
  infor_sign = signs.information,
})


local opts = { buffer = 0 }
map('n', '<F2>', '<cmd>Lspsaga rename<cr>', opts)
map('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>', opts)
map('x', '<leader>ca', '<cmd>Lspsaga range_code_action<cr>', opts)
map('n', 'K', '<cmd>Lspsaga hover_doc<cr>', opts)


map('n', '<leader>dn', '<cmd>Lspsaga diagnostic_jump_next<cr>')
map('n', '<leader>dp', '<cmd>Lspsaga diagnostic_jump_prev<cr>')
map('n', '<leader>ds', '<cmd>Lspsaga show_line_diagnostics<cr>')
map('n', '<leader>da', vim.diagnostic.setloclist)
