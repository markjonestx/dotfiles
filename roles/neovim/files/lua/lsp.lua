-- lsp configuration
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
end)

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp'},
        {name = 'buffer', keyword_length = 3},
        {name = 'luasnip', keyword_length = 2},
    },

    mapping = {
        -- Enter to confirm selection
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        
        -- Ctrl+Space to trigger menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snipplet placeholder
        ['<C-n>'] = cmp_action.luasnip_jump_forward(),
        ['<C-p>'] = cmp_action.luasnip_jump_backward()
    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()


