return {

    -- LSP Configuration
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        dependencies = {
            {
                'williamboman/mason.nvim',
                opts = { ui = { border = 'rounded' } }
            },
            {
                'williamboman/mason-lspconfig.nvim',
                opts = { automatic_enable = true }
            }
        },
        config = function()
            local lspconfig = require('lspconfig')
            local lsputil = require('lspconfig.util')
            local mason_lsp = require('mason-lspconfig')
            local mason_registry = require('mason-registry')

            if not mason_registry.is_installed({'puppet-editor-services'}) then
                if vim.fn.executable('puppet-languageserver') then
                    vim.lsp.config('puppet', {
                        cmd = { 'puppet-languageserver', '--stdio' },
                        filetypes = { 'puppet' },
                        root_dir = lsputil.root_pattern(unpack({ 'hiera.yaml', '.git' }))(),
                        single_file_support = true
                    })
                    vim.lsp.enable('puppet')
                end
            end


            -- Use Mason to autoconfigure LSP without arguments
            -- You can override options for a given LSP here
            mason_lsp.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({})
                end
            })
        end
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
        },
        init = function ()
            -- Customization for Pmenu (cmp)
            local set_hl = vim.api.nvim_set_hl
            set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })

            set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
            set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
            set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
            set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

            set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
            set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
            set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

            set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
            set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
            set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

            set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
            set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
            set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

            set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
            set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
            set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
            set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
            set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

            set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
            set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

            set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
            set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
            set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

            set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
            set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
            set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

            set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
            set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
            set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })
        end,
        opts = function ()
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            local luasnip = require('luasnip')


            local has_words_before = function()
              if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
              local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
              return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
            end

            return {
                window = {
                    completion = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                    documentation = cmp.config.window.bordered()
                },

                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = {
                            menu = 50,
                            abbr = 50
                        },
                        ellipsis_char = '...',
                        show_labelDetails = true,
                    })
                },

                sources = {
                    {name = 'git'},
                    {name = 'path'},
                    {name = 'nvim_lsp'},
                    {name = 'nvim_lua'},
                    {name = 'orgmode'},
                    {name = 'luasnip', keyword_length = 2},
                    {name = 'buffer', keyword_length = 3},
                },

                mapping = cmp.mapping.preset.insert({
                    -- Enter to confirm selection
                    ['<CR>'] = cmp.mapping.confirm({
                        select = false,
                        behavior = cmp.ConfirmBehavior.Insert,
                    }),

                    -- Ctrl+Space to trigger menu
                    ['<C-Space>'] = cmp.mapping.complete(),

                    -- Navigate between snipplet placeholder
                    --['<C-n>'] = luasnip.jump(1),
                    --['<C-p>'] = luasnip.jump(-1),


                    -- Navigate the documentation
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                }),

              sorting = {
                  priority_weight = 2,
                  comparators = {
                     -- Below is the default comparitor list and order for nvim-cmp
                     cmp.config.compare.offset,
                     -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                     cmp.config.compare.exact,
                     cmp.config.compare.score,
                     cmp.config.compare.recently_used,
                     cmp.config.compare.locality,
                     cmp.config.compare.kind,
                     cmp.config.compare.sort_text,
                     cmp.config.compare.length,
                     cmp.config.compare.order,
                  },
              },
            }
        end
    },

    -- Git Completions
    {
        "petertriho/cmp-git",
        dependencies = { 'hrsh7th/nvim-cmp' },
        lazy = false,
        opts = {
            gitlab = {
                hosts = {
                    'https://git.arasaka.sh',
                    'https://gitlab.jlab.org',
                    'https://code.jlab.org'
                },
            },
        },
        init = function()
            table.insert(require("cmp").get_config().sources, { name = "git" })
        end
    },

}
