local is_file_present = require('utils').is_file_present
local map = require('utils').map
local Terminal = require('toggleterm.terminal').Terminal


local M = {}


M.is_active = false
M.filetypes = {'html', 'css', 'astro', 'svelte'}

function M.get_cmd()
  local cmd = 'vite --open --host'
  if is_file_present('./package.json') then
    local dev = vim.fn.match(vim.fn.readfile('./package.json'), '"dev":') >= 0
    local start = vim.fn.match(vim.fn.readfile('./package.json'), '"start":') >= 0
    if dev or start then
      cmd = 'npm run' .. (dev and ' dev' or ' start')
    end
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
vim.api.nvim_create_autocmd('Filetype', { group = 'LiveServer', pattern = M.filetypes, callback = function() map('n','<A-l>', live_server) end })

return M
