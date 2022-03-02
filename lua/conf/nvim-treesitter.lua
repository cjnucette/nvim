require('nvim-treesitter.configs').setup({
  ensure_installed = 'maintained',
  ignore_install = {'vala'},
  highlight = { enable = true },
  indent = { enable = true, disable = {'html', 'css'} },
  matchup = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
  autotag = {
    enable = true,
  }
})
