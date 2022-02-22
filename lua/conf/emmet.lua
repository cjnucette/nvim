vim.g.user_emmet_mode = 'a'
vim.g.user_emmet_install_global = 0
vim.g.user_emmet_leader_key = '<leader>e'

vim.cmd[[
  augroup Emmet
    autocmd!
    autocmd FileType html,css,javascriptreact,typescriptreact EmmetInstall
  augroup END
]]
