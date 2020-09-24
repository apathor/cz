# Zsh Cz Config

# cz_zsh_history
# select from zsh history entries
cz_zsh_history() {
    cz -e "{3:}" -f 3: -i <(history -i 1)
}

# zleval COMMAND
# Insert output of command into zle buffer
zleval() {
    local out
    out=$(eval -- "$@" < "$TTY")
    BUFFER="${LBUFFER}${out}${RBUFFER}"
    CURSOR+="$#out"
}

# define cz zle widgets
cz-meta-p() { zleval cz meta -p; }
zle -N cz-meta-p

cz-meta-q() { zleval cz meta -q; }
zle -N cz-meta-q

cz-meta-r() { zleval cz meta -r; }
zle -N cz-meta-r

cz-meta-s() { zleval cz meta -s; }
zle -N cz-meta-s

cz-history() { zleval cz_zsh_history; }
zle -N cz-history

cz-unicode() { zleval cz -q unicode; }
zle -N cz-unicode

cz-git-status() { zleval cz -q git status; }
zle -N cz-git-status

cz-git-file() { zleval cz -q git file; }
zle -N cz-git-file

# bind keys
bindkey "^Xx" cz-meta-q
bindkey "^XX" cz-meta-p
bindkey "^Xz" cz-meta-r
bindkey "^XZ" cz-meta-s
bindkey "^Xr" cz-history
bindkey "^Xu" cz-unicode
bindkey "^Xg" cz-git-status
bindkey "^XG" cz-git-file
