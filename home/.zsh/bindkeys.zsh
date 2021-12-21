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

bindkey -e ## Default to standard emacs bindings

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# M-. let's me grab the last argument on the previous line.  M-m let's me cycle through them.
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word

autoload -U select-word-style
select-word-style bash

# Rebind some keys to call custom copy/paste functions
zle -N yanktoclipboard
zle -N pastefromclipboard
bindkey -a 'yy' yanktoclipboard
bindkey -a 'p' pastefromclipboard

