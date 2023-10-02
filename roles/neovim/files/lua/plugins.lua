-- Packages managed by Packer

return require('packer').startup(function(use)
    -- Let Packer manage itself
    use 'wbthomason/packer.nvim'

    -- Treesitter for syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- LSP Configuration
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        },
    }

    -- Git Completions
    use { "petertriho/cmp-git", requires  = "nvim-lua/plenary.nvim" }

    -- Autosave
    use "Pocco81/auto-save.nvim"

    -- Autotrim whitespaces and excess newlines
    use 'cappyzawa/trim.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        requires = { {'nvim-lua/plenary.nvim'} },
    }

    -- Nvim Code Actions Menu
    use {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
    }

    -- Code Action Identifier
    use 'kosayoda/nvim-lightbulb'

    -- LSP Kind, better Auto completion icons
    use 'onsails/lspkind.nvim'

    -- Dadbod (Databases, cause I'm crazy
    use 'tpope/vim-dadbod'
    use 'kristijanhusak/vim-dadbod-ui'

    -- Github Copilot, for intelligent autofill- where it makes sense
    use 'github/copilot.vim'

    -- R integration
    use 'jalvesaq/Nvim-R'

    -- Fugitive for git integration
    use 'tpope/vim-fugitive'

    -- Gitsigns for git integration
    use 'lewis6991/gitsigns.nvim'

    -- Automatic Indentation
    use 'nmac427/guess-indent.nvim'

    -- Theme
    use { "catppuccin/nvim", as = "catppuccin" }

    -- NVIM Tree
    use "nvim-tree/nvim-tree.lua"
    use "nvim-tree/nvim-web-devicons"

    -- Lualine for statusline
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    -- Notify for notifications
    use  'rcarriga/nvim-notify'

    -- Shows keybindings
    use 'folke/which-key.nvim'

end)
