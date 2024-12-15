export EDITOR=nvim
export MANPAGER="$EDITOR +Man!"
export MYSQL_PS1="mysql  \d  \R:\m:\s  "
export VIRTUAL_ENV_DISABLE_PROMPT=1
export NVM_DIR="$HOME/.nvm"  # Check this if using NVM
export LANG=en_US.UTF-8
export LC_MESSAGES="C"
export TERM=${TERM:-xterm-256color}
export DOCS=$HOME/documents
export DOTS=$HOME/.homesick/repos/Dotfiles
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_OPTS='--color fg:223,bg:-1,hl:65,fg+:142,bg+:-1,hl+:108 --color info:108,prompt:109,spinner:108,pointer:168,marker:168'
export FZF_CTRL_R_OPTS="--inline-info --exact"

command -v dircolors > /dev/null && eval "$(dircolors ~/.dircolors)"

export GOPROXY="https://proxy.golang.org,direct"
export GOSUMDB=off
export GO111MODULE=on
export FLYCTL_INSTALL="/home/stephen/.fly"
export DENO_INSTALL="/home/stephen/.deno"

export PATH="$DENO_INSTALL/bin:$FLYCTL_INSTALL/bin:$HOME/Android/Sdk/platform-tools:$HOME/Apps/usr-local-bin:$HOME/.rvm/bin:$PATH:/usr/local/go/bin:/usr/local/bin"
