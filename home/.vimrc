" Utility function for bootstrapping {{{
fun! LoadFiles(files)
    for file in a:files
        if filereadable(expand(file))
            execute "source " . file
        endif
    endfor
endfun
" }}}


" Bootstrap dotfiles {{{
    " Setup vim-plugin manager {{{
    fun! SetupVimPlug()
        " Define our install dir and add it to our runtime path
        let plugin_root_dir = expand('$HOME', 1) . '/.vim/plugins'
        let &rtp .= (empty(&rtp) ? '' : ',') . plugin_root_dir.'/vim-plug'

        " Clone vim-plug if we don't have it yet
        if !isdirectory(plugin_root_dir . '/vim-plug')
            echo "***********************************"
            echo "*   First time using this vimrc   *"
            echo "* Installing vim-plug and plugins *"
            echo "***********************************"
            silent execute '!git clone --depth=1 https://github.com/junegunn/vim-plug ' shellescape(plugin_root_dir . '/vim-plug', 1)
            let g:keelerm84_first_run = 1
        endif

        call LoadFiles([plugin_root_dir . '/vim-plug/plug.vim'])

        call plug#begin(plugin_root_dir)
        call LoadFiles(["~/.vim/bundles"])
        call plug#end()
    endfun

    call SetupVimPlug()
    " }}}

    " Install plugins on first run {{{
    if exists('g:keelerm84_first_run')
        PlugInstall
    endif
    " }}}

"Theming
"colorscheme gruvbox
colorscheme onehalfdark
scriptencoding utf-8
filetype on
filetype plugin on
syntax on

"Settings
set laststatus=2
set noshowmode
set showcmd                 "Shows what you are typing as a command
set number                  "Enables hybrid when set with relative
set relativenumber          "Relative line numbers
set nocompatible            "Noop
set mousehide
set termguicolors
set ignorecase              "Case insensitive search
set autoread                "Watch for file changse
set pastetoggle=<F2>
set hlsearch
set grepprg=grep\ -nH\ $*
set virtualedit=onemore     "Jump to the very end of a word and then go one more space over
set nomodeline              "Modeline opens up security vulnerabilities
set clipboard=unnamedplus
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smarttab
set rtp+=~/.fzf "FZF

autocmd BufWritePre * %s/\s\+$//e


let mapleader=" " "Map leader to space

"use system clipboard

"Buffers
autocmd BufEnter * :syntax sync fromstart

map <C-n> :NERDTreeToggle<CR>

"Split screen navigation remap hotkeys
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"List buffers and prepare to move into one
nnoremap <Leader>b :ls<CR>:b<Space>

"Open split
nnoremap <Leader>h :split<CR>
nnoremap <Leader>v :vsplit<CR>
"Go to last buffer
nnoremap <BS> <C-^>


"Save file with leader + s
nnoremap <leader>s :w<cr>
nnoremap <leader>q :q<cr>

"Navigate quickfix with arrows
nnoremap <Right> :cnext<CR>
nnoremap <Left> :cprev<CR>
nnoremap gp :Ggrep<Space>
nnoremap gb :Gblame<cr>

"Move to beginning/end of line without taking fingers off of home row
nnoremap H ^
nnoremap L $

"Escape out of insert mode
imap jj <ESC>

"Quickly paste default register while in insert mode
inoremap <C-F> <C-R>"

"Toggle tagbar to show function/property definitions
nmap <Leader>t :TagbarToggle<CR>
let g:tagbar_left = 1

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

" Autoreload vim after a vimrc change
augroup myvimrchooks
    au!
        autocmd bufwritepost .vimrc source ~/.vimrc
    augroup END

"If in a git repository then only search the files
"checked into git.
function! SmartFzfSearching()
    let root = s:get_git_root()
    if empty(root)
        Files
    else
        GFiles
    endif
endfunction

nnoremap <Leader>p :call SmartFzfSearching()<CR>

nmap g<C-p> :Files<CR>
nmap gs<C-p> :GFiles?<CR>
nmap <leader>T :BTags<CR>
nmap g<leader>T :Tags<CR>
nmap <leader>l :BLines<CR>
nmap g<leader>l :Lines<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>c :BCommits<CR>
nmap g<leader>c :Commits<CR>
nmap <leader>m :Marks<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '~20%' }
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


" Folding and unfolding
map ,f :set foldmethod=indent<cr>zM<cr>
map ,F :set foldmethod=manual<cr>zR<cr>

-call LoadFiles(["~/.vim/config/functions", "~/.vim/config/mappings", "~/.vim/config/environment", "~/.vim.local"])

