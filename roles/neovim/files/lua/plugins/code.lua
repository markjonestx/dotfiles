return {

    -- LSP Configuration
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        event = 'VeryLazy',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
        },
        init = function()
            local lsp_zero = require('lsp-zero')
            local lspconfig = require('lspconfig')
            local mason_lsp = require('mason-lspconfig')
            local cmp = require('cmp')
            local lspkind = require('lspkind')

            -- lsp configuration
            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            lsp_zero.extend_lspconfig({
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
                lsp_attach = lsp_attach,
                float_border = 'rounded',
                sign_text = true,
            })

            mason_lsp.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({})
                end,
            })

            local has_words_before = function()
              if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
              local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
              return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
            end

            cmp.setup({
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
                    {name = 'copilot'},
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

                    -- Copilot Tab-to-complete
                    ["<Tab>"] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end),

                    -- Ctrl+Space to trigger menu
                    ['<C-Space>'] = cmp.mapping.complete(),

                    -- Navigate between snipplet placeholder
                    ['<C-n>'] = lsp_zero.cmp_action().luasnip_jump_forward(),
                    ['<C-p>'] = lsp_zero.cmp_action().luasnip_jump_backward(),

                    -- Navigate the documentation
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                }),

              sorting = {
                    priority_weight = 2,
                    comparators = {
                       require("copilot_cmp.comparators").prioritize,

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
            })

        end
    },
    { 'hrsh7th/cmp-nvim-lsp' },
    {
        'williamboman/mason.nvim',
        opts = {
            ui = {
                border = 'rounded'
            }
        }
    },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
    {
        'hrsh7th/nvim-cmp',
        dependencies = { 'VonHeikemen/lsp-zero.nvim' },
        event = 'InsertEnter',
        config = function()
        end,
        init = function()
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
        end
    },
    { 'L3MON4D3/LuaSnip' },


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

    -- Nvim Code Actions Menu, deprecated
    -- { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' },



    -- Github Copilot, for intelligent autofill- where it makes sense
    {
        'zbirenbaum/copilot.lua',
        cmd = { 'Copilot' },
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        }
    },
    { 'zbirenbaum/copilot-cmp' },

}
