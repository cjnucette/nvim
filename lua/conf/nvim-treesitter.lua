require('nvim-treesitter.configs').setup({
  ensure_installed = 'maintained',
  highlight = { enable = true },
  indent = { enable = true, disable = {'html'} },
  matchup = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
})
