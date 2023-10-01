local autosave = require('auto-save')
local cmp = require('cmp')
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

-- Mason LSP configuration
mason.setup({
    ui = {
        border = 'rounded'
    }
})

mason_lsp.setup({
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            lspconfig.lua_ls.setup(lua_opts)
        end,
    }
})

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
            local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind
        end,
    },

    sources = {
        {name = 'path'},
        {name = 'nvim_lsp'},
        {name = 'buffer', keyword_length = 3},
        {name = 'luasnip', keyword_length = 2},
    },

    mapping = cmp.mapping.preset.insert({
        -- Enter to confirm selection
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        -- Ctrl+Space to trigger menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snipplet placeholder
        ['<C-n>'] = lsp_zero.cmp_action().luasnip_jump_forward(),
        ['<C-p>'] = lsp_zero.cmp_action().luasnip_jump_backward(),

        -- Navigate the documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    })
})

-- Git stuffs
gitsigns.setup()

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
