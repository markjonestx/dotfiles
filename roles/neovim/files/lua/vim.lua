-- Setup basic vim commands
local set = vim.opt

set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.number = true
set.relativenumber = true
set.colorcolumn = "79"
set.hlsearch = false
set.ignorecase = true
set.smartcase = true
set.mouse = "a"
set.clipboard = "unnamedplus"
set.breakindent = true
set.undofile = true
set.signcolumn = "yes"
vim.updatetime = 250
set.timeoutlen = 300
set.termguicolors = true


vim.cmd([[
    augroup resizer
        autocmd!
        autocmd VimResized * :wincmd =
    augroup END
]])

vim.cmd([[
    augroup returnCursor
        autocmd BufRead * autocmd FileType <buffer> ++once
        \ if &ft !~# 'commit\|rebase'
            \ && line("'\"") > 1 && line("'\"") <= line("$")
            \ | exe 'normal! g`"' |
        \ endif
    augroup END
]])


vim.cmd([[
    augroup systemdServiceFile
        autocmd!
        autocmd BufNewFile,BufRead *.service setlocal filetype=systemd
    augroup END
]])

vim.cmd([[
    augroup rustFile
        autocmd!
        autocmd FileType rust setlocal colorcolumn=99
    augroup END
]])

vim.cmd([[
    augroup puppetFile
        autocmd!
        autocmd FileType puppet setlocal shiftwidth=2
    augroup END
]])

vim.cmd([[
    augroup javaFile
        autocmd!
        autocmd FileType java setlocal colorcolumn=120
    augroup END
]])


vim.cmd([[
    augroup golangFile
        autocmd!
        autocmd FileType go setlocal colorcolumn=120
    augroup END
]])

vim.cmd([[
    augroup xmlFile
        autocmd!
        autocmd FileType xml setlocal expandtab&
    augroup END
]])

vim.cmd([[
    augroup javaFile
        autocmd!
        autocmd FileType java setlocal expandtab&
    augroup END
]])
