. ~/.zsh/functions.zsh
export PATH=$PATH:/usr/local/bin

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

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

export NVM_DIR="$HOME/.config"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
