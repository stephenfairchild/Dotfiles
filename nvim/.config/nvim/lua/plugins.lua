local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Theming
  use { "ellisonleao/gruvbox.nvim" }

  -- Searching
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    requires = {
      {'nvim-lua/plenary.nvim'}
    },
  }
  use 'scrooloose/nerdtree'

  -- Completion / Snippets
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hashivim/vim-terraform'

  -- Git
  use 'tpope/vim-fugitive'
  use 'github/copilot.vim'

  -- HTTP / DB
  use 'diepm/vim-rest-console'
  use {
    'NLKNguyen/pipe.vim',
    opt = true,
    requires = {{'NLKNguyen/pipe-mysql.vim', opt = true}}
  }
  use 'tpope/vim-dadbod'

  -- Editing
  use 'editorconfig/editorconfig-vim'
  use 'nvim-treesitter/nvim-treesitter'


  -- GraphQL
  use 'jparise/vim-graphql'

  -- Rust
  use 'rust-lang/rust.vim'
  use 'simrat39/rust-tools.nvim'

  -- Typescript
  use {
  "pmizio/typescript-tools.nvim",
      requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      config = function()
        require("typescript-tools").setup {}
      end,
  }

  -- Formatting
use('jose-elias-alvarez/null-ls.nvim')
use('MunifTanjim/prettier.nvim')
  if packer_bootstrap then
    require('packer').sync()
  end
end)

