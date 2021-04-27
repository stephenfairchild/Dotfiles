command -v nvim > /dev/null && export EDITOR=nvim || export EDITOR=vim
command -v nvim > /dev/null && export MANPAGER="$EDITOR +Man!" || export MANPAGER="vim -c MANPAGER -"

export MYSQL_PS1="mysql  \d  \R:\m:\s  "
export VIRTUAL_ENV_DISABLE_PROMPT=1

if [ -e "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use
fi

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && . $HOME/.tmuxinator/scripts/tmuxinator || true
[[ -f $HOME/.homesick/repos/homeshick/homeshick.sh ]] && source $HOME/.homesick/repos/homeshick/homeshick.sh || true

export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting
export LANG=en_US.UTF-8
export LC_MESSAGES="C"

# System
export PATH=$PATH:/usr/local/bin
export TERM=${TERM:-xterm-256color}
export LANG=en_US.UTF-8
export DOCS=$HOME/Documents

# FZF
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_OPTS='
    --color fg:223,bg:-1,hl:65,fg+:142,bg+:-1,hl+:108
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
'
export FZF_CTRL_R_OPTS="--inline-info --exact"
command -v dircolors > /dev/null && eval "$(dircolors ~/.dircolors)"

# NVM
export NVM_DIR="$HOME/.config"

# Go
export GOPROXY="https://proxy.golang.org,direct"
export GOSUMDB=off
export GO111MODULE=on

# Android
export PATH="$PATH:$HOME/Android/Sdk/platform-tools"

