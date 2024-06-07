# -*- sh-mode -*-
. "$HOME"/.bashrc

# configure cz
export CZ_BINS="fzf fzy pick"

# dump keybinds
awk -F# '/^bind/ { print "#" $2 "\n" $1 "\n" }' "$HOME"/.bashrc >&2
