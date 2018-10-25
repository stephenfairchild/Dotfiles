. ~/.zsh/functions.zsh

. ~/.zsh/git.zsh
. ~/.zsh/themes/spaceship.zsh
load_file "aliases.zsh"
load_file "functions.zsh"
load_file "environment.zsh"
load_file "setopt.zsh"
load_file "exports.zsh"
load_file "completion.zsh"
load_file "bindkeys.zsh"
load_file "history.zsh"

powerline-daemon -q
. /usr/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh

[ -e ~/.zshrc.local ] && . ~/.zshrc.local || true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

