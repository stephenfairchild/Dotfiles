
source ~/.config/nvim/config/functions

call SetupVimPlug()

call LoadFiles([
    \"~/.config/nvim/config/environment",
    \"~/.config/nvim/config/commands",
    \"~/.config/nvim/config/mappings",
    \"~/.config/nvim/.vim.local",
\])
