# Convenient function to allow local overrides for all sourced files
function load_file {
    [ -e ~/.zsh/${1} ] && . ~/.zsh/${1} || true
    [ -e ~/.zsh.local/${1} ] && . ~/.zsh.local/${1} || true
}

function man {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

. ~/.zsh/functions/docker.zsh

function start-ops {
    cd $HOME/Apps && \
    ./docker-rs/docker.sh start && \
    ./operations-sqr-io/bin/docker.sh start
}

function clean-swp {
    rm -rvf $HOME/.cache/vim/swap/*
}

# Gracefully stop all docker containers
function stop-all {
    docker stop $(docker ps -a -q)
}

function phptags {
    ctags -R --PHP-kinds=cfi . && \
    ctags -R --PHP-kinds=cfi -f tags.vendors vendor
}

yanktoclipboard(){
    echo $BUFFER | xsel -i -b
}
pastefromclipboard(){
    RBUFFER=$(xsel -o -b </dev/null)$RBUFFER
}
zle -N yanktoclipboard
zle -N pastefromclipboard
bindkey -a 'yy' yanktoclipboard
bindkey -a 'p' pastefromclipboard
