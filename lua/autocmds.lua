local cmd = vim.cmd

-- Highlight selection on yank
cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Remap escape to leave terminal mode
cmd [[
  augroup Terminal
    autocmd!
    au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
    au TermOpen * set nonu
  augroup end
]]

cmd [[
  augroup center_buffer_remember_cursor_pos
    autocmd!
    autocmd BufRead * normal zz
    autocmd VimResized * :wincmd =
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  augroup END
]]

-- close nvim if coc-explorer is the last buffer
cmd [[
augroup close_cocexplorer
  autocmd!
  autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif 
  autocmd BufEnter * if bufname('#') =~ 'coc-explorer' && bufname('%') !~ 'coc-explorer' && winnr('$') > 1 | execute "normal \<C-^>" | endif
augroup END
]]

cmd [[
augroup ejs
  autocmd!
  autocmd BufNewFile,BufRead *.ejs set filetype=html
augroup END
]]

cmd [[
augroup fix_devicon_color
  autocmd!
  autocmd ColorScheme * lua require('nvim-web-devicons').setup();
augroup END
]]

cmd [[
augroup goyo_limelight
  autocmd!
  autocmd User GoyoEnter Limelight
  autocmd User GoyoLeave Limelight!
augroup END
]]

-- depends on pandoc (https://pandoc.org) be intalled
cmd [[
augroup read_word_docs
  autocmd!
  autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -tplain -o /dev/stdout
augroup END
]]

cmd [[
augroup refresh_on_change
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *  if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
augroup END
]]

-- cmd [[
--   augroup formatter_format_on_save
--     autocmd!
--     autocmd BufWritePost *.lua FormatWrite
--   augroup END
-- ]]
