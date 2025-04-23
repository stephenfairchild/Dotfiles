. ~/.zsh/functions.zsh

load_file "exports.zsh"
load_file "aliases.zsh"
load_file "setopt.zsh"
load_file "completion.zsh"
load_file "bindkeys.zsh"
load_file "history.zsh"
load_file "git.zsh"
load_file "nvm.zsh"
load_file "mx.zsh"

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
