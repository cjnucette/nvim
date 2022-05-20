local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local isempty = function(s)
  return not s or s == ''
end

-- get current filename
local filename = function()
  local filename = vim.fn.expand('%:t')
  local extension = nil

  if filename == nil then
    return filename
  else
    extension = vim.fn.expand('%:t:e')

    local default = isempty(extension) and true or false
    local icon, icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = default })
    local hl_group = 'FileIconColor' .. extension

    vim.api.nvim_set_hl(0, hl_group, { fg = icon_color })

    return ' ' .. '%#' .. hl_group .. '#' .. icon .. '%*' .. ' ' .. '%#LineNr#' .. filename .. '%*'
  end
end

local gps = function()
  local gps_ok, gps = pcall(require, 'nvim-gps');
  if not gps_ok then return nil end

  local location_ok, location = pcall(gps.get_location, {})
  if not location_ok then return nil end

  if not gps.is_available() then return nil end

  if location == 'error' then return nil end

  if isempty(location) then return nil end

  return ' ' .. require('icons').ui.ChevronRight .. ' ' .. location
end

-- autocommands
local winbar = augroup('Winbar', { clear = true })
autocmd({ 'CursorMoved', 'BufWinEnter', 'BufFilePost' }, { group = winbar, callback = function()
  local winbar_filetype_exclude = {
    'help',
    'vim-plug',
    'neogitstatus',
    'neo-tree',
    'lspinfo',
    'lsp-installer'
  }

  if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return
  end

  -- get the value
  local fname = filename() or ''
  local loc = gps() or ''
  local value = fname .. loc

  -- set vim.opt_local.winbar to the value
  vim.opt_local.winbar = value and value or nil
end
})
