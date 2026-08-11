-- There are some big changes between neovim 0.10 and 0.12. EL10 defaults
-- to 0.10, and I have our EL9 servers on 0.10 as well.

local compat = require('config.compat')

-- Set the highest version (nil for latest)
local mason_version
local mason_lsp_config_version
local lspconfig_version

if not compat.nvim_011 then
    mason_version = 'v1.11.0'
    mason_lsp_config_version = 'v1.32.0'
    lspconfig_version = 'v1.8.0'
end

return {

    -- LSP Configuration
    {
        'mason-org/mason-lspconfig.nvim',
        lazy = false,

        version = mason_lsp_config_version,

        dependencies = {
            {
                'mason-org/mason.nvim',
                version = mason_version,
                opts = {
                    ui = { border = 'rounded' },
                    install_root_dir = vim.fn.stdpath('data') .. '/mason-' .. compat.profile,
                }
            },

            {
                'neovim/nvim-lspconfig',
                version = lspconfig_version
            },

            'hrsh7th/cmp-nvim-lsp'
        },

        config = function()
            local opts = {
                automatic_enable = true,
                ensure_installed = {
                    -- devops
                    'bashls',
                    'jsonls',
                },
            }

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            if compat.nvim_011 then
                vim.lsp.config("*", { capabilities = capabilities })

                require('mason-lspconfig').setup(opts)
                return
            end

            -- Legacy LSP configuration

            local lspconfig = require('lspconfig')

            -- ltex_plus isn't in this older Mason
            local legacy_baseline = {}
            for _, server in ipairs(opts.ensure_installed) do
                if server ~= 'ltex_plus' then
                    table.insert(legacy_baseline, server)
                end
            end

             require('mason-lspconfig').setup({
                ensure_installed = legacy_baseline,

                handlers = {
                    function(server)
                        lspconfig[server].setup({ capabilities = capabilities })
                    end
                }
            })

        end,
    },


    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",

        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'onsails/lspkind.nvim',
            'hrsh7th/cmp-nvim-lua',
            'petertriho/cmp-git',
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

            return {
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },

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

                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'nvim_lua' },
                    { name = 'git' },
                }, {
                    { name = 'buffer', keyword_length = 3 }
                }),

                mapping = cmp.mapping.preset.insert({
                    -- Enter to confirm selection
                    ['<CR>'] = cmp.mapping.confirm({
                        select = false,
                        behavior = cmp.ConfirmBehavior.Insert,
                    }),

                    -- Ctrl+Space to trigger menu
                    ['<C-Space>'] = cmp.mapping.complete(),

                    -- Navigate the documentation
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                }),

              sorting = {
                  priority_weight = 2,
                  comparators = {
                     cmp.config.compare.offset,
                     cmp.config.compare.exact,
                     cmp.config.compare.sort_text,
                     cmp.config.compare.score,
                     cmp.config.compare.recently_used,
                     cmp.config.compare.locality,
                     cmp.config.compare.kind,
                     cmp.config.compare.length,
                     cmp.config.compare.order,
                  },
              },
            }
        end,

        config = function(_, opts)
            local cmp = require('cmp')

            cmp.setup(opts)

            require('cmp_git').setup({
                gitlab = {
                    hosts = {
                        'https://git.frappe.coffee',
                        'https://gitlab.jlab.org',
                        'https://code.jlab.org'
                    }
                }
            })
        end
    },

    -- Typist Support
    {
        'chomosuke/typst-preview.nvim',
        ft = 'typst',
        version = '1.*',
        opts = {
            open_cmd = 'flatpak run org.mozilla.firefox %s --class typist-preview',
            dependencies_bin = {
                ['tinymist'] = 'tinymist',
                ['websocat'] = 'websocat'
            },
        }
    }
}
