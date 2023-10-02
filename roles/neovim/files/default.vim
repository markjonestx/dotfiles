" Setup basic vim commands
set tabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber
set colorcolumn=79
set nohlsearch
set ignorecase
set smartcase
set mouse="a"
set clipboard="unnamedplus"
set breakindent
set undofile
set signcolumn="yes"
set updatetime=250
set timeoutlen=300
set termguicolors
set syntax=on

nnoremap <Space> <Nop>
vnoremap <Space> <Nop>

nnoremap <C-u> <C-u>zz
vnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
vnoremap <C-d> <C-d>zz

xnoremap p "_dP

augroup returnCursor
    autocmd!
    autocmd BufReadPost *
        \ if &filetype !~# '^\(commit\|git\|fugitive\|gitcommit\|gitrebase\|svn\|hg\|diff\)$'
        \ && line("'\"") > 0 && line("'\"") <= line("$")
        \ | exe "normal! g`\""
        \ | endif
augroup END

augroup rustColorColumn
    autocmd!
    autocmd FileType rust setlocal colorcolumn=99
augroup END

augroup puppetIndent
    autocmd!
    autocmd FileType puppet setlocal shiftwidth=2
augroup END

augroup javaColorColumn
    autocmd!
    autocmd FileType java setlocal colorcolumn=120
augroup END

augroup xmlIndent
    autocmd!
    autocmd FileType xml setlocal expandtab&
augroup END

augroup javaIndent
    autocmd!
    autocmd FileType java setlocal expandtab&
augroup END
