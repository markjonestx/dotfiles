local keymap = vim.keymap

-- General
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
keymap.set({ 'n', 'v' }, '<C-u>', '<C-u>zz')
keymap.set({ 'n', 'v' }, '<C-d>', '<C-d>zz')
keymap.set('x', 'p', '"_dP')
keymap.set({ 'n', 'v' }, '<leader>x', '"_x')
keymap.set({ 'n', 'v' }, '<leader>d', '"_d')
keymap.set('n', '<C-w>v', '<C-w>v<C-w>l')
keymap.set('n', '<C-w>s', '<C-w>s<C-w>j')

-- Improved wordwrap
keymap.set('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
keymap.set('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- NvimTree and Undotree
keymap.set('n', '<leader>tt', '<cmd>NvimTreeToggle<CR>')
keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle)

-- Telescope
keymap.set('n', '<leader><Space>', '<cmd>Telescope buffers<CR>')

-- LSP
keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>')

-- Diagnostics
keymap.set('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
keymap.set('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
