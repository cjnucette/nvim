setlocal foldenable foldmethod=expr foldexpr=nvim_treesitter#foldexpr() foldlevel=99
" setlocal suffixes^="init.lua,.lua"
setlocal include=require
setlocal define=function
setlocal suffixesadd=init.lua
setlocal suffixesadd=.lua
setlocal path^=/home/cjnucette/.config/nvim/lua
setlocal path^=/home/cjnucette/.config/nvim/lua/conf
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
