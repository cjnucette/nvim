local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('YankHighlight', {})
autocmd('TextYankPost', { group = 'YankHighlight', pattern = '*', callback = function() vim.highlight.on_yank() end})

augroup('Terminal', {})
autocmd('TermOpen', { group = 'Terminal', pattern = '*', command = [[tnoremap <buffer> <Esc> <c-\><c-n>]]})
autocmd('TermOpen', { group = 'Terminal', pattern = '*', command = [[set nonu]]})

-- cmd [[
--   augroup center_buffer_remember_cursor_pos
--     autocmd!
--     autocmd BufRead * normal zz
--     autocmd VimResized * :wincmd =
--     autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
--   augroup END
-- ]]
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

-- cmd [[
-- augroup fix_devicon_color
--   autocmd!
--   autocmd ColorScheme * lua require('nvim-web-devicons').setup();
-- augroup END
-- ]]
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
-- cmd [[
-- augroup read_word_docs
--   autocmd!
--   autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -tplain -o /dev/stdout
-- augroup END
-- ]]
augroup('ReadOfficeDocuments', {})
autocmd(
  'BufReadPost',
  {
    group = 'ReadOfficeDocuments',
    pattern = {'*.doc', '*.docx', '*.rtf', '*.odp', '*.odt'},
    command = [[silent %!pandoc "%" -tplain -o /dev/stdout]]
  }
)

-- cmd [[
-- augroup refresh_on_change
--   autocmd!
--   autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *  if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
-- augroup END
-- ]]
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
