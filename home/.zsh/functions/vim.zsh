# Kill all swap files left over from nvim.
clean-swp() {
    rm -rvf $HOME/.local/share/nvim/swap/*
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


# Rebind some keys to call custom copy/paste functions
zle -N yanktoclipboard
zle -N pastefromclipboard
bindkey -a 'yy' yanktoclipboard
bindkey -a 'p' pastefromclipboard

