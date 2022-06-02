local toggle_ok, toggleterm = pcall(require, 'toggleterm')
if not toggle_ok then return end

toggleterm.setup({
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == 'horizontal' then
      return vim.o.lines * 0.5
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
  -- open_mapping = [[<c-\>]],
  open_mapping = [[<c-t>]],
  -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
  direction = 'float',
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode, true creates a delay
  persist_size = true,
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    border = 'curved',
    -- width = <value>,
    height = tonumber(string.format('%.0f', vim.o.lines * 0.5)),
    winblend = 3,
    highlights = {
      border = 'Normal',
      background = 'Normal',
    },
  },
})

local Terminal = require('toggleterm.terminal').Terminal
local node = Terminal:new({ cmd = 'node', hidden = true })
local deno = Terminal:new({ cmd = 'deno', hidden = true })
local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true })

function _G.nodeToggle()
  node:toggle()
end

function _G.denoToggle()
  deno:toggle()
end

function _G.lazygitToggle()
  lazygit:toggle()
end

require('utils').map('n','<A-n>', nodeToggle)
require('utils').map('n','<A-d>', denoToggle)
require('utils').map('n','<A-g>', lazygitToggle)
