return {
    -- Theme
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        init = function()
            vim.cmd(':colorscheme catppuccin')
        end,
        opts = {
            flavour = "mocha",
            show_end_of_buffer = true,
            transparent_background = true,
            term_colors = true,
            integrations = {
                mason = true,
                cmp = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
                notify = true,
                nvimtree = true,
                treesitter = true,
                telescope = {
                    enabled = true
                },
                which_key = true
            },
        }
    },

    -- Lualine for statusline
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme = 'catppuccin',
            }
        }
    },

    -- Treesitter for syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = false,
        config = function()
            local configs = require('nvim-treesitter.configs')

            configs.setup({
                ensure_installed = {
                    'c', 'lua', 'vim', 'vimdoc',
                    'rust', 'python', 'go',
                    'yaml', 'json', 'puppet'
                },
                auto_install = true,
                highlight = {
                    enable = true,
                },
                additional_vim_regex_highlighting = false,
            })
        end,
    },

    -- Notify for notifications
    {
        'rcarriga/nvim-notify',
        lazy = false,
        opts = { background_colour = "#000000" }
    },

    -- Code Action Identifier
    {
        'kosayoda/nvim-lightbulb',
        event = 'VeryLazy',
        opts = { autocmd = { enabled = true }}
    },

    -- LSP Kind, better Auto completion icons
    { 'onsails/lspkind.nvim', event = 'VeryLazy' },

    -- Gitsigns for git integration
    { 'lewis6991/gitsigns.nvim', event = 'VeryLazy' },

}
