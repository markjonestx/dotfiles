-- Unceremoniously stolen from Lazy's tutorial
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = " "


local profile = require('config.compat').profile

require("lazy").setup({
    root = vim.fn.stdpath('data') .. '/lazy-' .. profile,
    lockfile = vim.fn.stdpath('data') .. '/lazy-lock-' .. profile .. '.json',
    spec = {
        { import = "plugins" },
    },
    defaults = {
        lazy = true,
    },
    install = {
        colorscheme = { "catppuccin" },
    },
    checker = {
        enabled = true,
        notify = true,
    },
    change_detection = {
        enabled = false,
        notify = true,
    },
    ui = {
        border = 'single'
    },
    rocks = {
        enabled = true
    }
})
