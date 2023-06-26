-- Configure the Theme

require('monokai-pro').setup({
    transparent_background = true,
    terminal_colors = false,
    filter = 'pro'
})

vim.cmd(':colorscheme monokai-pro')

