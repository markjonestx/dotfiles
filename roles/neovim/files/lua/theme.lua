--
-- Global Configuration
--

-- set termguicolors
vim.opt.termguicolors = true

--
-- Setup NVIM Tree
--

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    }
})


--
-- Configure the Color Theme
--
require('catppuccin').setup({
    flavour = "mocha",
    transparent_background = true,

    integrations = {
        cmp = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        mason = true,
    },
})

vim.cmd(':colorscheme catppuccin')


--
-- Configure the Status Line
--
require('lualine').setup({
    options = {
        theme = 'catppuccin',
    }
})

--
-- Configure the notification background
--
require("notify").setup({
  background_colour = "#000000",
})
