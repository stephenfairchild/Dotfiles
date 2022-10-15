local o = vim.o
local wo = vim.wo
local bo = vim.bo

o.completeopt=menu,menuone,noselect
vim.cmd[[colorscheme nord]]
o.background='dark'
vim.cmd('syntax on')
--scriptencoding utf-8
--filetype on
--filetype plugin on
o.foldmethod='indent'
o.foldlevel=1
o.foldclose=all
o.conceallevel=0
o.laststatus=2
o.showtabline=2
o.noshowmode=true
o.showcmd=true
o.number=true
o.relativenumber=true
o.nocompatible=true
o.mousehide=true
o.termguicolors=true
o.autoread=true
o.pastetoggle='<F2>'
o.hlsearch=true
o.virtualedit='onemore'
o.nomodeline=true
o.clipboard='unnamedplus'
o.tabstop=4
softtabstop=4
o.expandtab=true
o.shiftwidth=4
o.smarttab=true
o.nowrapscan=true

vim.cmd('let g:rustfmt_autosave = 1')
vim.cmd('let NERDTreeShowHidden=1') -- show dotfiles

