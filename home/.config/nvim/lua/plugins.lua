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
  use 'shaunsingh/nord.nvim'

  -- Searching
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-github.nvim'},
    },
  }
  use 'scrooloose/nerdtree'

  -- Git
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'

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

  if packer_bootstrap then
    require('packer').sync()
  end
end)
