local autosave = require('auto-save')
local cmp = require('cmp')
local cmpgit = require('cmp_git')
local copilot = require('copilot')
local copilot_cmp = require('copilot_cmp')
local gitsigns = require('gitsigns')
local indent = require('guess-indent')
local lightbulb = require('nvim-lightbulb')
local lspconfig = require('lspconfig')
local lspkind = require('lspkind')
local lsp_zero = require('lsp-zero')
local mason = require('mason')
local mason_lsp = require('mason-lspconfig')
local trim = require('trim')


-- Treesitter configuration
require 'nvim-treesitter.configs'.setup {
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
}

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


-- Mason LSP configuration
mason.setup({
    ui = {
        border = 'rounded'
    }
})

mason_lsp.setup({
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({})
        end,
    },
})

-- Copilot configuration
copilot.setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
})

copilot_cmp.setup()

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
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
        format = function(entry, vim_item)
            local kind = lspkind.cmp_format({
                mode = "symbol_text",
                maxwidth = 50,
                symbol_map = {
                    Copilot = "",
                },
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind
        end,
    },

    sources = {
        {name = 'copilot'},
        {name = 'git'},
        {name = 'path'},
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
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

-- Git stuffs
gitsigns.setup()
cmpgit.setup({
    gitlab = {
        hosts = {
            'https://git.araska.sh',
            'https://gitlab.jlab.org',
            'https://code.jlab.org',
        }
    }
})

-- Extras
autosave.setup()

indent.setup()

lightbulb.setup({
    autocmd = { enable = true }
})

trim.setup({
    trim_last_line = false,
    trim_first_line = false
})
