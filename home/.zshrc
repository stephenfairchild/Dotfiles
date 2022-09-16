. ~/.zsh/functions.zsh

load_file "aliases.zsh"
load_file "setopt.zsh"
load_file "exports.zsh"
load_file "completion.zsh"
load_file "bindkeys.zsh"
load_file "history.zsh"
load_file "git.zsh"
load_file "mx.zsh"

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

# Load FZF
. /usr/share/fzf/completion.zsh
. /usr/share/fzf/key-bindings.zsh

# Load NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

eval "$(starship init zsh)"

# bun completions
[ -s "/home/stephen/.bun/_bun" ] && source "/home/stephen/.bun/_bun"

# Bun
export BUN_INSTALL="/home/stephen/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
