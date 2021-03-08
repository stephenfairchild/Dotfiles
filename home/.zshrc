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
. /usr/lib/python3.9/site-packages/powerline/bindings/zsh/powerline.zsh

[ -e ~/.zshrc.local ] && . ~/.zshrc.local || true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Start ssh-agent and only run one at a time.
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
fi

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
