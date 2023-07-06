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

    -- Theme
    use {
        'loctvl842/monokai-pro.nvim',
        config = function()
            require('monokai-pro').setup()
        end
    }

    -- Autosave
    use {
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup {

            }
        end
    }

    -- NVIM Tree
    use "nvim-tree/nvim-tree.lua"
    use "nvim-tree/nvim-web-devicons"

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

end)

