local execute = vim.api.nvim_command

if vim.fn.empty(vim.fn.glob('~/.config/nvim/autoload/plug.vim')) > 0 then
  execute(
    [[silent !curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim]]
  )
  vim.cmd([[ autocmd VimEnter * PlugInstall --sync ]])
end

local Plug = vim.fn['plug#']

vim.call('plug#begin', '/home/cjnucette/.config/nvim/plugged')
-- dependencies
Plug('MunifTanjim/nui.nvim') -- package-info dependency
Plug('nvim-lua/plenary.nvim') -- Telescope dependecy
Plug('kyazdani42/nvim-web-devicons') -- various packages

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('RRethy/nvim-treesitter-endwise')

-- themes
Plug('marko-cerovac/material.nvim')
Plug('folke/tokyonight.nvim')
Plug('joshdick/onedark.vim')
Plug('shaunsingh/nord.nvim')
Plug('dracula/vim', {['as'] = 'dracula'})

-- lsp
Plug('neovim/nvim-lspconfig')
Plug('williamboman/nvim-lsp-installer')
Plug('jose-elias-alvarez/null-ls.nvim')
Plug('j-hui/fidget.nvim')

-- completion and snippets
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/vim-vsnip')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-nvim-lua')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-vsnip')

-- emmet (lsp versions suck)
Plug('mattn/emmet-vim')

-- statusline
Plug('rebelot/heirline.nvim')

-- telescope
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })
Plug('nvim-telescope/telescope-file-browser.nvim')

-- git
Plug('lewis6991/gitsigns.nvim')
Plug('tpope/vim-fugitive')

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
Plug('iamcco/markdown-preview.nvim', { ['for'] = 'markdown', ['do'] = 'cd app && yarn install' })
Plug('andymass/vim-matchup')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('vuki656/package-info.nvim')
Plug('rrethy/vim-hexokinase', { ['do'] = 'make hexokinase' })
Plug('karb94/neoscroll.nvim')
Plug('NTBBloodbath/color-converter.nvim')

-- Development
Plug('~/Workspace/code/nvim/plugins/stackmap.nvim')

vim.call('plug#end')

-- Enable plugins with default configurarion

vim.notify = require('notify')
require('fidget').setup()
require('nvim-autopairs').setup({ check_ts = true })
require('Comment').setup()
require('neoscroll').setup()
