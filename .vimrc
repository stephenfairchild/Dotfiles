so ~/.vim/plugins.vim

set nocompatible              " be iMproved, required
filetype off                  " required
set t_Co=256
set term=screen-256color
"Theme / Styles
colorscheme gruvbox
set background=dark
syntax on
set laststatus=2
set noshowmode
set number

autocmd BufEnter * :syntax sync fromstart


let g:NERDTreeDirArrows=0
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
autocmd BufWritePre * %s/\s\+$//e

" FZF
set rtp+=~/.fzf

" Map leader to space
let mapleader=" "

" Go to last buffer
nnoremap <BS> <C-^>

map <C-o> :NERDTreeToggle<CR>
nnoremap <Leader>nn :NERDTreeWinSize=60<cr>


"Open split
nnoremap <Leader>h :split<CR>
nnoremap <Leader>v :vsplit<CR>

"Split screen navigation remap hotkeys
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"List buffers and prepare to move into one
nnoremap <Leader>b :ls<CR>:b<Space>

"Save file with leader + s
nnoremap <leader>s :w<cr>
nnoremap <leader>ss :wq!<cr>
nnoremap <leader>q :q<cr>

"Navigate quickfix with arrows
nnoremap <Right> :cnext<CR>
nnoremap <Left> :cprev<CR>

"Move to beginning/end of line without taking fingers off of home row
nnoremap H ^
nnoremap L $

"Escape out of insert mode
imap jj <ESC>

"Toggle between buffers
nnoremap <leader><tab> :b#<CR>

"Close all buffers
nnoremap <Leader>cc  :bufdo bd<cr>

"FZF open
nnoremap <Leader>p :Files<CR>

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

"Reload .vimrc
nnoremap <leader><F5> :source $HOME/.vimrc<cr>

"Go To Definition with ctags
nnoremap <leader>] <C-]><cr>

nnoremap gp :Ggrep<Space>
nnoremap gb :Gblame<cr>

