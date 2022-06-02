local toggleTerm_ok, _ = pcall(require, 'toggleterm')
if not toggleTerm_ok then
  vim.notify('LiveServe depends on toggleterm', 'error', { title = 'live_server' })
  return {
    setup = function()
      return {
        is_available = false,
      }
    end
  }
end

local is_file_present = require('utils').is_file_present
local map = require('utils').map
local Terminal = require('toggleterm.terminal').Terminal
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- @class liveServerConfig
-- @field cmd string
-- @field start_mapping string
-- @field quit_mapping string
-- @field enabled_filetypes string[]
-- @script_names string[]
local config = {
  cmd = 'vite --open --host',
  start_mapping = '<A-l>',
  quit_mapping = 'q',
  enabled_filetypes = { 'html' },
  script_names = { 'dev', 'start' }
}

--@class liveServer
--@field is_active boolean
--@field is_available boolean
local M = {}

M.is_active = false
M.is_available = false



function M.set_is_available(bool)
  M.is_available = bool
end

function M.get_script_name()
  local script = nil
  if not is_file_present('./package.json') then
    return nil
  end

  for _, name in ipairs(config.script_names) do
    if vim.fn.match(vim.fn.readfile('./package.json'), '"' .. name .. '":') >= 0 then
      script = name
      M.set_is_available(true);
      break
    end
  end


  return script
end

function M.get_cmd()
  local cmd = config.cmd

  local script_name = M.get_script_name()

  if M.is_available and script_name then
    cmd = 'npm run ' .. script_name
  end

  return cmd
end

function M.stop()
  M.liveServer:shutdown()
end

function M.start()
  M.liveServer:toggle()
end

function M.handle_click()
  if M.is_active then M.stop() else M.start() end
end

function M.get_config()
  return config
end

--@param opts liveServerConfig?
--@return any
function M.setup(opts)
  opts = opts or {}
  config = vim.tbl_deep_extend('force', config, opts)

  M.set_is_available(vim.tbl_contains(config.enabled_filetypes, vim.fn.expand('%:e')))

  M.liveServer = Terminal:new({
    cmd = M.get_cmd(),
    hidden = true,
    start_in_insert = false,
    count = 3,
    on_open = function()
      M.is_active = true
    end,
    on_exit = function()
      M.is_active = false
    end,
    close_on_exit = true,
  })
  -- autocommands
  local Live_Server = augroup('live_server', { clear = true })
  autocmd('TermOpen', { group = Live_Server, pattern = 'term://*', callback = function()
    map('t', config.quit_mapping, '<cmd>bwipeout!<cr>', { noremap = true, silent = true, buffer = 0 })
  end })

  -- mappings
  map('n', config.start_mapping, M.start, { buffer = 0 })

  return M
end

return M
