export EDITOR=nvim
export MANPAGER="$EDITOR +Man!"
export MYSQL_PS1="mysql  \d  \R:\m:\s  "
export VIRTUAL_ENV_DISABLE_PROMPT=1
export NVM_DIR="$HOME/.nvm"
export LANG=en_US.UTF-8
export LC_MESSAGES="C"
export TERM=${TERM:-xterm-256color}
export LANG=en_US.UTF-8
export DOCS=$HOME/documents
export DOTS=$HOME/.homesick/repos/Dotfiles
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_OPTS='
    --color fg:223,bg:-1,hl:65,fg+:142,bg+:-1,hl+:108
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
'
export FZF_CTRL_R_OPTS="--inline-info --exact"
command -v dircolors > /dev/null && eval "$(dircolors ~/.dircolors)"
export NVM_DIR="$HOME/.config"
export GOPROXY="https://proxy.golang.org,direct"
export GOSUMDB=off
export GO111MODULE=on
export FLYCTL_INSTALL="/home/stephen/.fly"

export PATH="$FLYCTL_INSTALL/bin:$PATH"
export PATH="$PATH:$HOME/Android/Sdk/platform-tools"
export PATH="$PATH:$HOME/Apps/usr-local-bin"
export PATH=$PATH:/usr/local/bin
export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting

