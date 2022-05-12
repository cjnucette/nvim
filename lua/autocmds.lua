local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('YankHighlight', {})
autocmd('TextYankPost', { group = 'YankHighlight', pattern = '*', callback = function() vim.highlight.on_yank() end})

augroup('Terminal', {})
autocmd('TermOpen', { group = 'Terminal', pattern = '*', command = [[tnoremap <buffer> <Esc> <c-\><c-n>]]})
autocmd('TermOpen', { group = 'Terminal', pattern = '*', command = [[set nonu]]})

augroup('CenterBufferRememberCursorPosition', {})
autocmd('BufRead', { group = 'CenterBufferRememberCursorPosition', pattern = '*', command = [[:normal zz]]})
autocmd('VimResized', { group = 'CenterBufferRememberCursorPosition', pattern = '*', command = [[:wincmd =]]})
autocmd(
  'BufReadPost',
  {
    group = 'CenterBufferRememberCursorPosition',
    pattern = '*',
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]
  }
)

augroup('FixDevIconColor', {})
autocmd(
  'ColorScheme',
  {
    group = 'FixDevIconColor',
    pattern = '*',
    callback = function() require('nvim-web-devicons').setup() end
  }
)

-- depends on pandoc (https://pandoc.org) be intalled
augroup('ReadOfficeDocuments', {})
autocmd(
  'BufReadPost',
  {
    group = 'ReadOfficeDocuments',
    pattern = {'*.doc', '*.docx', '*.rtf', '*.odp', '*.odt'},
    command = [[silent %!pandoc "%" -tplain -o /dev/stdout]]
  }
)

augroup('RefreshBufferOnExternalChange', {})
autocmd(
  {'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI'},
  {
    group = 'RefreshBufferOnExternalChange',
    pattern = '*',
    command = [[if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
]]
  }
)
