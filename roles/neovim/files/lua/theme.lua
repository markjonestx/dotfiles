-- Configure the Theme

require('monokai-pro').setup({
    transparent_background = false,
    terminal_colors = false,
    filter = 'pro'
})

vim.cmd(':colorscheme monokai-pro')

