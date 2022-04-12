local ft_to_parser = require('nvim-treesitter.parsers').filetype_to_parsername
ft_to_parser.nunjucks = 'tsx'

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'html',
    'css',
    'javascript',
    'typescript',
    'vim',
    'astro',
    'toml',
    'yaml',
    'svelte',
    'bash',
    'rust',
    'lua',
  },
  highlight = { enable = true, disable = { 'html' } },
  indent = { enable = true, disable = { 'html', 'css', 'typescriptreact' } },
  matchup = {
    enable = true,
  },
  -- endwise = {
  --  enable = true,
  -- },
  autotag = {
    enable = true,
  },
})
