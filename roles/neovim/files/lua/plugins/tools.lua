return {
    -- Telescope
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { {'nvim-lua/plenary.nvim'} },
        keys = {
            { '<leader>fd', '<cmd>Telescope fd<CR>' },
            { '<leader>rg', '<cmd>Telescope live_grep<CR>' },
            { '<leader><Space>', '<cmd>Telescope buffers<CR>' },
            {
                '<leader>noti',
                '<cmd>lua require("telescope").extensions.notify.notify()<CR>'
            }
        },
        cmd = { 'Telescope' },
        opts = {
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
        }
    },
    { 'nvim-lua/plenary.nvim' },

    -- NVIM Tree
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        init = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
        opts = {
            sort_by = "case_sensitive",
            view = {
                width = 30,
            },
            renderer = {
                group_empty = true,
            }
        }
    },
    { 'nvim-tree/nvim-web-devicons' },

    -- Undo Tree, to make my life easier
    {
        'mbbill/undotree',
        keys = {
            { '<leader>tu', vim.cmd.UndotreeToggle }
        }
    },

    {
        'ojroques/nvim-osc52',
        enabled = vim.fn.has('nvim-0.10.0') ~= 1,
        init = function()
            require('osc52').setup {
                tmux_passthrough = true,
            }

            function copy()
              if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
                require('osc52').copy_register('+')
              end
            end

            vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})
        end,
    },

    -- Code Actions Menu
    {
        'aznhe21/actions-preview.nvim',
        keys = { '<leader>ca' },
        init = function()
            vim.keymap.set(
                { 'n' }, '<leader>ca', require('actions-preview').code_actions
            )
        end
    },

    -- Autosave
    { "Pocco81/auto-save.nvim", event = 'InsertEnter' },

    -- Autotrim whitespaces and excess newlines
    {
        'cappyzawa/trim.nvim',
        event = 'InsertEnter',
        opts = {
            trim_last_line = false,
            trim_first_line = false,
        },
    },

    -- Shows keybindings
    {
        'folke/which-key.nvim',
        event = "VeryLazy",
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },

    -- Fugitive for git integration
    { 'tpope/vim-fugitive', cmd = {'Git'} },

    -- Automatic Indentation
    { 'nmac427/guess-indent.nvim', lazy = false },
}

