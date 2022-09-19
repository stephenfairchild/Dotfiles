local map = vim.api.nvim_set_keymap
options = { noremap = true }

map('n', '<Space>', '', {})
vim.g.mapleader = ' '

---- Movement / Panes / Windows
map('n', '<Right>', ':cnext<CR>', options)
map('n', '<Left>', ':cprev<CR>', options)
map('n', 'bg', ':Git blame<CR>', options)
map('n','<leader>nt', ':NERDTreeToggle<CR>', options)
map('n','<leader>ff', ':Telescope find_files<CR>', options)
map('n','<leader>fg', ':Telescope live_grep<CR>', options)
map('n','<leader>b', ':Telescope buffers<CR>', options)
map('n','<leader>fh', ':Telescope help_tags<CR>', options)
map('n','<leader>ft', ':Telescope treesitter<CR>', options)
map('n', '<C-Up>', ':resize +2<CR>', options)
map('n', '<C-Down>', ':resize -2<CR>', options)
map('n', '<C-Left>', ':vertical resize -2<CR>', options)
map('n', '<C-Right>', ':vertical resize +2<CR>', options)
map('i', ';;', '<Esc>A;<Esc>', options)
map('i', ',,', '<Esc>A,<Esc>', options)
