local map = vim.api.nvim_set_keymap
options = { noremap = true }

map('n', '<Space>', '', {})
vim.g.mapleader = ' '

map('n', '<Right>', ':cnext<CR>', options)
map('n', '<Left>', ':cprev<CR>', options)
map('n','<leader>nt', ':NERDTreeToggle<CR>', options)
map('n','<leader>ff', ':Telescope find_files<CR>', options)
map('n','<leader>fg', ':Telescope live_grep<CR>', options)
map('n','<leader>b', ':Telescope buffers<CR>', options)
map('n','<leader>fh', ':Telescope help_tags<CR>', options)
map('n','<leader>fb', ':Telescope bookmarks<CR>', options)
map('n','<leader>ft', ':Telescope treesitter<CR>', options)
map('n', '<C-Up>', ':resize +2<CR>', options)
map('n', '<C-Down>', ':resize -2<CR>', options)
map('n', '<C-Left>', ':vertical resize -2<CR>', options)
map('n', '<C-Right>', ':vertical resize +2<CR>', options)
map('i', ';;', '<Esc>A;<Esc>', options)
map('i', ',,', '<Esc>A,<Esc>', options)
map('n','<leader>jt', "<cmd>lua run_jest_test()<CR>", options)

-- Runs Jest on the file the cursor is over
function run_jest_test()
    -- TODO: If split is open, then use the existing split
    vim.cmd('vsplit')
end
