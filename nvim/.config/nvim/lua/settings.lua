local o = vim.o

o.completeopt=menu,menuone,noselect
vim.cmd[[colorscheme gruvbox]]
o.background='dark'
vim.cmd('syntax on')
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
o.noswapfile=true

vim.cmd('let g:rustfmt_autosave = 1')
vim.cmd('autocmd BufNewFile *.sh 0r ~/.config/nvim/skeleton-templates/shell.sh')

-- Preserve make file tabs
vim.cmd([[autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0]])
