-- Setup basic vim commands
local set = vim.opt

set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.number = true
set.relativenumber = true
set.colorcolumn = "79"

vim.cmd([[
    augroup rustColorColumn
        autocmd!
        autocmd FileType rust setlocal colorcolumn=99
    augroup END
]])

vim.cmd([[
    augroup puppetIndent
        autocmd!
        autocmd FileType puppet setlocal shiftwidth=2
    augroup END
]])

