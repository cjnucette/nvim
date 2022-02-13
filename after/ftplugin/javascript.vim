setlocal foldenable foldmethod=expr foldexpr=nvim_treesitter#foldexpr() foldlevel=99

nnoremap <buffer><silent> <leader>cl viwyoconsole.log({<c-r>*});<esc>
