-- Treesitter configuration

require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'c', 'lua', 'vim', 'vimdoc',
        'rust', 'python', 'go',
        'yaml', 'json'
    },

    auto_install = true,

    additional_vim_regex_highlighting = false
}

