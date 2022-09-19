require('plugins')
require('settings')
require('mappings')

require('telescope').load_extension('gh')

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "rust", "javascript", "graphql", "typescript" },
  highlight = {
    enable = true,
  },
}
