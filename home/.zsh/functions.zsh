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

function clean-swp {
    rm -rvf $HOME/.local/share/nvim/swap/*
}

# Gracefully stop all docker containers
function stop-all {
    docker stop $(docker ps -a -q)
}

phptags() {
    ctags -R --PHP-kinds=cfi . && \
    ctags -R --PHP-kinds=cfi -f tags.vendors vendor
}

yanktoclipboard() {
    echo $BUFFER | xsel -i -b
}
pastefromclipboard() {
    RBUFFER=$(xsel -o -b </dev/null)$RBUFFER
}

setKeyboardLight() {
    dbus-send --system --type=method_call  --dest="org.freedesktop.UPower" "/org/freedesktop/UPower/KbdBacklight" "org.freedesktop.UPower.KbdBacklight.SetBrightness" int32:$1
}

zle -N yanktoclipboard
zle -N pastefromclipboard
bindkey -a 'yy' yanktoclipboard
bindkey -a 'p' pastefromclipboard
