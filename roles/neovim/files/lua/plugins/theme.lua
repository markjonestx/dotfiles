-- To support NVIM 0.10 - 0.12
local compat = require('config.compat')

local treesitter_parsers = {
    -- Core / editor
    'lua',
    'vim',
    'vimdoc',

    -- Development
    'c',
    'cpp',
    'go',
    'rust',
    'python',

    -- Devops
    'bash',
    'json',
    'toml',
    'dockerfile',
    'hcl',
    'yaml',

    -- Documentation
    'markdown',
    'markdown_inline',
    'typst',
}

return {
    -- Theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,

        opts = {
            flavour = "mocha",
            transparent_background = true,
            term_colors = true,

            lsp_styles = {
                virtual_text = {
                    errors = { 'italic' },
                    hints = { 'italic' },
                    warnings = { 'italic' },
                    information = { 'italic' },
                },

                inlay_hints = { background = true }
            },

            auto_integrations = true,
        },

        config = function(_, opts)
            local catppuccin = require('catppuccin')
            catppuccin.setup(opts)
            vim.cmd.colorscheme('catppuccin-nvim')
        end
    },

    -- Lualine for statusline
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme = 'catppuccin-nvim',
            },
            sections = {
                lualine_c = { { 'filename', path = 1 } }
            }
        }
    },

    -- Treesitter for syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',

        branch = compat.nvim_012 and 'main' or 'master',

        lazy = false,
        build = ':TSUpdate',

        config = function()
            local parser_dir = vim.fn.stdpath('data') .. '/treesitter-' .. compat.profile

            if compat.nvim_012 then
                local treesitter = require('nvim-treesitter')

                treesitter.setup({ install_dir = parser_dir })
                treesitter.install(treesitter_parsers)

                local available = {}
                for _, lang in ipairs(treesitter.get_available()) do
                    available[lang] = true
                end

                vim.api.nvim_create_autocmd('FileType', {
                    pattern = '*',

                    -- Hook to run on every opened file
                    callback = function(args)
                        local filetype = vim.bo[args.buf].filetype
                        local lang = vim.treesitter.language.get_lang(
                            filetype
                        )

                        -- Quit early if TS can't handle this filetype
                        if not lang or not available[lang] then
                            return
                        end

                        if vim.treesitter.language.add(lang) then
                            pcall(vim.treesitter.start, args.buf, lang)
                            return
                        end

                        -- Install if it's not found, with async nonsense
                        treesitter.install({ lang }):await(function(err, inst)
                            if err or not inst then
                                return
                            end

                            vim.schedule(function()
                                local valid_buf = vim.api.nvim_buf_is_valid(args.buf)
                                local is_filetype = vim.bo[args.buf].filetype ~= filetype

                                if not (vaild_buf or filetype) then
                                    return
                                end

                                pcall(vim.treesitter.start, buf, lang)
                            end)
                        end)
                    end
                })

                return
            end


            -- Legacy Neovim (0.10 and 0.11)

            vim.opt.runtimepath:prepend(parser_dir)

            require('nvim-treesitter.configs').setup({
                parser_install_dir = parser_dir,

                ensure_installed = treesitter_parsers,
                auto_install = true,
                highlight = { enable = true, },
                additional_vim_regex_highlighting = false,
            })
        end,
    },

    -- Notify for notifications
    {
        'rcarriga/nvim-notify',
        lazy = false,

        opts = { background_colour = "#000000" },

        config = function(_, opts)
            local notify = require('notify')
            notify.setup(opts)

            vim.notify = notify
        end,
    },

    -- Code Action Identifier
    {
        'kosayoda/nvim-lightbulb',
        enabled = compat.nvim_011,

        lazy = false,
        opts = { autocmd = { enabled = true } }
    },

    -- Gitsigns for git integration
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {},
    },
}
