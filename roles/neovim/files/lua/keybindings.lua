local keymap = vim.keymap

-- Telescope
keymap.set('n', '<leader>rg', '<cmd>Telescope live_grep<CR>')
keymap.set('n', '<leader>fd', '<cmd>Telescope fd<CR>')
keymap.set('n', '<leader>org', '<cmd>ObsidianSearch<CR>')
keymap.set('n', '<leader>ofd', '<cmd>ObsidianQuickSwitch<CR>')
