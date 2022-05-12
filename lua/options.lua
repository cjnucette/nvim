local set = vim.opt
local fn = vim.fn
local cmd = vim.cmd

-- Options

set.number = true
set.signcolumn = 'number'
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.shiftround = true
set.mouse = 'a'
set.modeline = true
set.splitbelow = true
set.splitright = true
set.cursorline = true
set.wrap = false
set.digraph = true
set.nrformats:append({ 'alpha' })
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.list = true
-- set.listchars = { tab = '>-', space = '·' }
set.listchars = { tab = '>-', trail = '·' }
set.clipboard:append({ 'unnamed', 'unnamedplus' })
set.scrolloff = 3
set.autoread = true
-- opt.fillchars:append('eob:\')

-- autocomplete window transparency --
if fn.exists('+pumblend') then -- feature detection ;)
  set.pumblend = 10
end
if fn.exists('+winblend') then -- feature detection ;)
  set.winblend = 10
end

--- undo ---
if fn.has('persistent_undo') then
  set.undodir = vim.fn.expand('~/.undodir') -- ~ doesn't expand in lua
  set.undofile = true
end

--- use ag with grep ---
if fn.executable('ag') then
  set.grepprg = 'ag\\--vimgrep\\ $*'
  set.grepformat:prepend({ '%f:%l:%c:%m' })
end

--- coc recommended ---

set.hidden = true --hides unsaved buffers
set.backup = false
set.writebackup = false
cmd([[set shortmess+=c]])
-- set.shortmess = set.shortmess + { c = true } -- doesn't work ???
-- set.shortmess:append({ c = true }) -- doesn't work ???
set.updatetime = 300 --Smaller update time for CursorHold & CursorHoldI

-- folding
set.foldenable = true
set.foldlevel = 99
set.foldmethod = 'expr'
-- set.foldexpr = vim.fn['nvim_treesitter#foldexpr']()
cmd([[ set foldexpr=nvim_treesitter#foldexpr() ]])
-- set.foldtext = vim.fn.getline(vim.v.foldstart) .. '...' .. vim.fn.trim(vim.v.foldend)
cmd([[ set foldtext=getline(v:foldstart).'...'.trim(getline(v:foldend)) ]])
set.foldnestmax = 3
set.foldminlines = 1
set.fillchars = { fold = ' ' }

--- end coc ---
--enable bash aliases
-- cmd([[let $BASH_ENV="./.vim_bash_env"]])
vim.env.BASH_ENV = './.vim_bash_env'
