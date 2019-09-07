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

# Kill all swap files left over from nvim.
clean-swp() {
    rm -rvf $HOME/.local/share/nvim/swap/*
}

# Gracefully stop all docker containers.
stop-all() {
    docker stop $(docker ps -a -q)
}

# Kill all shell jobs running in the background.
killalljobs() {
    for pid in $( jobs -p ); do kill -9 $pid ; done ;
}

# Generate a tags file in the current directory. This is used
# for searching and navigating directories quickly.
phptags() {
    ctags -R --PHP-kinds=cfi . && \
    ctags -R --PHP-kinds=cfi -f tags.vendors vendor
}

# Vim hack to paste to and from clipboard to take contents
# in and out of vim.
yanktoclipboard() {
    echo $BUFFER | xsel -i -b
}

# Vim hack to paste to and from clipboard to take contents
# in and out of vim.
pastefromclipboard() {
    RBUFFER=$(xsel -o -b </dev/null)$RBUFFER
}

# Set the light on the keyboard to the brightness of the passed in argument. 10
# works pretty nice.
setKeyboardLight() {
    dbus-send --system --type=method_call  --dest="org.freedesktop.UPower" "/org/freedesktop/UPower/KbdBacklight" "org.freedesktop.UPower.KbdBacklight.SetBrightness" int32:$1
}

zle -N yanktoclipboard
zle -N pastefromclipboard
bindkey -a 'yy' yanktoclipboard
bindkey -a 'p' pastefromclipboard
