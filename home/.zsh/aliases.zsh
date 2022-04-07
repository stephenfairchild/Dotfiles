# vim
alias vim="nvim"

# ls
alias ls="ls -N --color=auto"
alias l="ls -lhF"
alias ll="ls -alhF"

# git
alias g='git'
alias gr='[ ! -z `git rev-parse --show-toplevel` ] && cd `g rev-parse --show-toplevel || pwd`'
alias gb='g branch'
alias gd='g diff'
alias gdc='gd --cached'
alias ga='g add'
alias gap='ga -p'
alias gc='g commit --verbose'
alias gca='gc --amend'
alias gco='g checkout'
alias gl='g log'
alias gll='g ll'
alias gs='g status'
alias gsp='g show -p'
alias gp='g pull'
alias gpr='gp --rebase'
alias gra='g rebase --abort'
alias grc='g rebase --continue'
alias gP='g push'
alias gm='g merge'
alias gg='g grep'
alias gst='g stash'
alias gstl='gst list'
alias gstd='gst drop'
alias gstp='gst pop'
alias gsta='gst apply'
alias gsts='gst save'
alias gstsu='gsts -u'
alias gpoh='gP origin HEAD'
# This will squash all commits on the current branch into one new commit with a new message.
# Helpful to cleanup old commits that are now irrelevant. Will require a force push.
alias gsq='g reset $(g merge-base main $(g rev-parse --abbrev-ref HEAD))'
alias gprs='gh pr status'

# tmux
alias tm='tmux new'
alias tmux='tmux -2 -u'
alias tl='tmux list-sessions'
alias tks='tmux kill-session'

# docker
alias docker-prune=' \
  docker container prune -f ; \
  docker image prune -f ; \
  docker network prune -f ; \
  docker volume prune -f '

alias list-audio='pactl list short sinks' # show possible sound devices that can be selected.

alias sail='bash vendor/bin/sail'

[ -e ~/.aliases.local ] && . ~/.aliases.local || true
