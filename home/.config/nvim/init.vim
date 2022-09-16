let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.config/nvim/plugins/vim-plug')
"==================================
" Theming
"==================================
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

"==================================
" Searching
"==================================
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter'

"==================================
" Git
"==================================
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

"==================================
" HTTP / DB
"==================================
Plug 'diepm/vim-rest-console'
Plug 'NLKNguyen/pipe.vim'
Plug 'NLKNguyen/pipe-mysql.vim'
Plug 'tpope/vim-dadbod'

"==================================
" Editing
"==================================
Plug 'editorconfig/editorconfig-vim'

"==================================
" GraphQL
"==================================
Plug 'jparise/vim-graphql'

"==================================
" Rust
"==================================
Plug 'rust-lang/rust.vim'

call plug#end()

colorscheme gruvbox
set background=dark
syntax on
scriptencoding utf-8
filetype on
filetype plugin on
set conceallevel=0
set laststatus=2
set showtabline=2
set noshowmode
set showcmd
set number
set relativenumber
set nocompatible
set mousehide
set termguicolors
set autoread
set pastetoggle=<F2>
set hlsearch
set grepprg=grep\ -nH\ $*
set virtualedit=onemore
set nomodeline
set clipboard=unnamedplus
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smarttab
set rtp+=~/.fzf "FZF
set nowrapscan

"===================================================
" Third Party / Plugins / Libraries
"===================================================
let g:rustfmt_autosave = 1
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-h': 'split',
    \ 'ctrl-v': 'vsplit' }

    let g:fzf_layout = { 'down': '~40%' }
    let g:fzf_colors = { 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'GruvboxAqua'],
        \ 'fg+':     ['fg', 'String'],
        \ 'bg+':     ['bg', 'Normal'],
        \ 'hl+':     ['fg', 'GruvboxBlue'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'prompt':  ['fg', 'GruvboxPurple'],
        \ 'pointer': ['fg', 'GruvboxPurple'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment'] }

"FZF open
function! s:get_git_root()
    if exists('*fugitive#repo')
        try
            return fugitive#repo().tree()
        catch
        endtry
    endif
    let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
    return v:shell_error ? '' : root
endfunction

"If in a git repository then only search the files checked into git.
function! SmartFzfSearching()
    let root = s:get_git_root()
    if empty(root)
        Files
    else
        GFiles
    endif
endfunction

"===================================================
" Leader
"===================================================
let mapleader=" "

"==================================
" Movement / Panes / Windows
"==================================
nnoremap <Leader>h :split<CR>
nnoremap <Leader>v :vsplit<CR>
nnoremap <BS> <C-^>
nnoremap <Right> :cnext<CR>
nnoremap <Left> :cprev<CR>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"==================================
" Searching
"==================================
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>p :call SmartFzfSearching()<CR>
nmap g<C-p> :Files<CR>
nmap <leader>l :BLines<CR>
nmap g<leader>l :Lines<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>m :Marks<CR>

"==================================
" Git
"==================================
nnoremap gp :Ggrep<Space>
nmap gs<C-p> :GFiles?<CR>
nnoremap gb :Git blame<cr>
nmap <leader>c :BCommits<CR>
nmap g<leader>c :Commits<CR>

"==================================
" Coc
"==================================
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

"==================================
" NERDTree
"==================================
map <Leader>nt :NERDTreeToggle<CR>
