local fn = vim.fn
local M = {}

M.map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

M.signs = {
  error = '',
  warning = '',
  information = '',
  hint = '',
}

M.capitalize = function(str)
  return (str:gsub('^%l', string.upper))
end

M.get_color = function(hlgroup, attr)
  return fn.synIDattr(fn.synIDtrans(fn.hlID(hlgroup)), attr, 'gui')
end

M.is_file_present = function(filename)
  return vim.fn.filereadable(vim.fn.expand(filename)) == 1
end

function M.is_empty(s)
  return s == nil or s == ''
end

return M
