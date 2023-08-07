-- Packages managed by Packer

return require('packer').startup(function(use)
    -- Let Packer manage itself
    use 'wbthomason/packer.nvim'

    -- Treesitter for syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- LSP Configuration
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        },
    }

    -- Autosave
    use {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup {

            }
        end
    }

    -- Autotrim whitespaces and excess newlines
    use {
        'cappyzawa/trim.nvim',
        config = function() require('trim').setup({
            trim_last_line = false,
        }) end,
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Dadbod (Databases, cause I'm crazy
    use 'tpope/vim-dadbod'
    use 'kristijanhusak/vim-dadbod-ui'

    -- Github Copilot, for intelligent autofill- where it makes sense
    use 'github/copilot.vim'

    -- Gitsigns for git integration
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

    -- Automatic Indentation
    use {
        'nmac427/guess-indent.nvim',
        config = function() require('guess-indent').setup() end,
    }

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
    use {
        'rcarriga/nvim-notify',
        config = function()
            vim.notify = require('notify')
            vim.notify.setup({
                background_colour = '#00',
            })
        end
    }

end)

