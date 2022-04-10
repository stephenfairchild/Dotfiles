. ~/.zsh/functions.zsh

. ~/.zsh/git.zsh
. ~/.zsh/themes/spaceship.zsh
load_file "aliases.zsh"
load_file "functions.zsh"
load_file "setopt.zsh"
load_file "exports.zsh"
load_file "completion.zsh"
load_file "bindkeys.zsh"
load_file "history.zsh"

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

# TODO (ssh-agent-cleanup)
# Start ssh-agent and only run one at a time.
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
fi

[ -e ~/.zshrc.local ] && . ~/.zshrc.local || true

# Load FZF
. /usr/share/fzf/completion.zsh
. /usr/share/fzf/key-bindings.zsh

# Load NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load Powerline
powerline-daemon -q
. /usr/lib/python3.10/site-packages/powerline/bindings/zsh/powerline.zsh


