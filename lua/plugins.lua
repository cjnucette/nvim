local execute = vim.api.nvim_command
local autocmd = vim.api.nvim_create_autocmd

if vim.fn.empty(vim.fn.glob('~/.config/nvim/autoload/plug.vim')) > 0 then
  execute(
    [[silent !curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim]]
  )
  autocmd('VimEnter', { command = 'PlugInstall --sync' })
  -- vim.cmd([[ autocmd VimEnter * PlugInstall --sync ]])
end

local Plug = vim.fn['plug#']

vim.call('plug#begin', vim.fn.stdpath('config') .. '/plugged')
-- dependencies
Plug('MunifTanjim/nui.nvim') -- package-info, regexplainer dependency
Plug('nvim-lua/plenary.nvim') -- Telescope and others dependecy
Plug('kyazdani42/nvim-web-devicons') -- various packages

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('nvim-treesitter/playground')
Plug('RRethy/nvim-treesitter-endwise')
Plug('SmiteshP/nvim-gps')

-- syntax
Plug('LnL7/vim-nix')

-- themes
Plug('marko-cerovac/material.nvim')
Plug('folke/tokyonight.nvim')
Plug('joshdick/onedark.vim')
Plug('shaunsingh/nord.nvim')
Plug('dracula/vim', { ['as'] = 'dracula' })
Plug('projekt0n/github-nvim-theme')

-- lsp
Plug('neovim/nvim-lspconfig')
Plug('williamboman/nvim-lsp-installer')
Plug('j-hui/fidget.nvim')
Plug('stevearc/dressing.nvim')

-- completion and snippets
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-nvim-lua')
Plug('hrsh7th/cmp-nvim-lsp-signature-help')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/vim-vsnip')
Plug('hrsh7th/cmp-vsnip')
Plug('https://github.com/DeepInThought/vscode-shell-snippets.git',
  { ['do'] = 'npm install' })
Plug('dsznajder/vscode-es7-javascript-react-snippets',
  { ['do'] = 'yarn install --frozen-lockfile && yarn compile' })

-- formatter
-- Plug('mhartington/formatter.nvim')
Plug('lukas-reineke/lsp-format.nvim') -- and efm language server

-- statusline
Plug('rebelot/heirline.nvim')

-- telescope
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug('nvim-telescope/telescope-file-browser.nvim')

-- git
Plug('lewis6991/gitsigns.nvim')
Plug('tpope/vim-fugitive')

-- file explorer
Plug('nvim-neo-tree/neo-tree.nvim')

-- others
Plug('akinsho/bufferline.nvim')
Plug('akinsho/toggleterm.nvim')
Plug('machakann/vim-sandwich')
Plug('milisims/nvim-luaref')
Plug('rcarriga/nvim-notify')
Plug('windwp/nvim-autopairs')
Plug('windwp/nvim-ts-autotag')
Plug('markonm/traces.vim')
Plug('szw/vim-maximizer')
Plug('numToStr/Comment.nvim')
Plug('iamcco/markdown-preview.nvim',
  { ['for'] = 'markdown', ['do'] = 'cd app && yarn install' })
Plug('andymass/vim-matchup')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('vuki656/package-info.nvim') -- deps: nui
Plug('rrethy/vim-hexokinase', { ['do'] = 'make hexokinase' })
Plug('karb94/neoscroll.nvim')
Plug('NTBBloodbath/color-converter.nvim')
Plug('ahmedkhalf/project.nvim')
Plug('bennypowers/nvim-regexplainer') -- deps: nui,plenary
Plug('b0o/schemastore.nvim')
Plug('mg979/vim-visual-multi', { ['branch'] = 'master' })
Plug('folke/todo-comments.nvim')
Plug('Mofiqul/trld.nvim')
Plug('linty-org/key-menu.nvim')

-- Development
-- Plug('~/Workspace/code/nvim/plugins/stackmap.nvim')
-- Plug('~/Workspace/code/lua/safe-defaults.nvim')

vim.call('plug#end')

-- Enable plugins with default configurarion

require('Comment').setup({})
require('neoscroll').setup()
require('todo-comments').setup()
require('dressing').setup()
require('trld').setup()
require('regexplainer').setup({
  display = 'popup',
  popup = {
    border = {
      style = 'solid',
    },
  },
})
vim.notify = require('notify')
require('fidget').setup({
  sources = {
    ltex = {
      ignore = true,
    },
  },
})
require('nvim-autopairs').setup({
  check_ts = true
})
