local compat = require('config.compat')

local telescope_tag
local telescope_version

if not compat.nvim_011 then
    telescope_tag = '0.1.8'
else
    telescope_version = '*'
end

return {
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',

        tag = telescope_tag,
        version = telescope_version,

        cmd = { 'Telescope' },
        dependencies = { 'nvim-lua/plenary.nvim' },

        keys = {
            { '<leader>fd', '<cmd>Telescope fd<CR>' },
            { '<leader>rg', '<cmd>Telescope live_grep<CR>' },
            { '<leader><Space>', '<cmd>Telescope buffers<CR>' },
            {
                '<leader>noti',
                '<cmd>lua require("telescope").extensions.notify.notify()<CR>'
            },
        },

        opts = {
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
        },

        config = function(_, opts)
            local telescope = require('telescope')

            telescope.setup(opts)

            telescope.load_extension('notify')
        end
    },


    -- Trouble for Errors
    {
      "folke/trouble.nvim",
      opts = {},
      cmd = "Trouble",

      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    },

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
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 30,
            },
            renderer = {
                group_empty = true,
            }
        }
    },

    -- Undo Tree, to make my life easier
    {
        'mbbill/undotree',
        keys = {
            { '<leader>ut', '<cmd>UndotreeToggle<cr>' }
        }
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
            trim_current_line = false
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
    { 'tpope/vim-fugitive', cmd = { 'Git' } },

    -- Automatic Indentation
    {
        'nmac427/guess-indent.nvim',

        event = { 'BufReadPre', 'BufNewFile' },

        opts = {}
    },

    -- Image support
    {
        '3rd/image.nvim',
        build = false,
        opts = {
            processor = 'magick_cli'
        }
    },

    {
        'r-pletnev/pdfreader.nvim',
        lazy = false,

        dependencies = {
            'folke/snacks.nvim',
            'nvim-telescope/telescope.nvim'
        },

        opts = {}
    },

    -- Snack's menu for Code Actions
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,

        keys = {
            {
              "<leader>ca",
              vim.lsp.buf.code_action,
              desc = "Display Code Actions",
            },
        },

        opts = {
            picker = {
                enabled = true,
                ui_select = true,

                layouts = {
                    select = {
                        layout = {
                            relative = 'cursor',
                            row = 1,
                            width = 70,
                            min_width = 0,
                        }
                    }
                }
            }
        }
    }
}
