
source ~/.config/nvim/config/functions

call SetupVimPlug()

call LoadFiles([
    \"~/.config/nvim/config/environment",
    \"~/.config/nvim/config/commands",
    \"~/.config/nvim/config/mappings",
    \"~/.config/nvim/config/google_python_style.vim",
    \"~/.config/nvim/.vim.local",
\])
