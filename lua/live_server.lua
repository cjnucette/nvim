local is_file_present = require('utils').is_file_present
local map = require('utils').map
local Terminal = require('toggleterm.terminal').Terminal


local M = {}


M.is_active = false
-- M.filetypes = {'html', 'css', 'astro', 'svelte'}
--
function M.has_start_scripts()
  local script_name = ''
  if is_file_present('./package.json') then
    local dev = vim.fn.match(vim.fn.readfile('./package.json'), '"dev":') >= 0
    local start = vim.fn.match(vim.fn.readfile('./package.json'), '"start":') >= 0

    if dev then
      script_name = ' dev'
    elseif start then
      script_name = ' start'
    end

    return dev or start, script_name
  end

  return false, script_name
end

function M.get_cmd()
  local cmd = 'vite --open --host'

  local ok, script_name = M.has_start_scripts()
  if ok then
      cmd = 'npm run' .. script_name
  end

  return cmd
end


local liveServer = Terminal:new({
  cmd = M.get_cmd(),
  hidden = true,
  on_open = function ()
    M.is_active = true
  end,
  on_exit = function ()
    M.is_active = false
  end,
  close_on_exit = true,
})

function _G.live_server()
  liveServer:toggle()
end

function M.start()
  liveServer:toggle()
end

function M.stop(self)
  self.is_active = false
end

vim.api.nvim_create_augroup('LiveServer', {})
vim.api.nvim_create_autocmd('Filetype', { group = 'LiveServer', callback = function() map('n','<A-l>', live_server) end })

return M
