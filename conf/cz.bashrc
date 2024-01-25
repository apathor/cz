# Bash Cz Config

. cz

# Disable graphical line selection for the shell
export CZ_GUI=0

# Set rofi theme
# export CZ_ROFI_THEME="solarized"

# Set dmenu font
# export CZ_DMENU_FONT="Unifont:normal:pixelsize=14"

# Core Functionality
# Insert selected cz plugin output into the readline buffer at cursor
bind -x '"\C-xx":rleval cz meta -q' # insert field(s)
bind -x '"\C-xX":rleval cz meta -p' # insert line
bind -x '"\C-xz":rleval cz meta -r' # insert command output
bind -x '"\C-xZ":rleval cz meta -s' # insert command string
bind -x '"\C-xc":cz meta -r'        # just run command

# Shell Utilities
# Insert text useful in the shell
bind -x '"\C-xr":rleval -i cz -q bash history {0}'  # insert selected line from bash history matching current word
bind -x '"\C-x!":rleval -i cz -q argv {0:}'         # insert word selected from current readline buffer
bind -x '"\C-xu":rleval -i cz -u unicode character' # insert selected unicode character
bind -x '"\C-xU":rleval -i cz -u unicode symbol'    # insert selected unicode symbol
bind -x '"\C-x,":rleval -w cz -q whence {0}'        # replace word with matching command path

# Directory Navigation
# Change directory to selected directory above or below current directory
bind -x '"\C-x<":cz -re "cd {0}" ancestor'
bind -x '"\C-x>":cz -re "cd {0}" descendant'

# Git
# Insert selected paths from git repo in the current directory into the readline buffer
bind -x '"\C-xg":rleval cz -q git status'      # insert path of selected modified file
bind -x '"\C-xG":rleval cz -q git file'        # insert path of selected git tracked file

# File Lookup
# Replace the word under readline cursor with a selected file
bind -x '"\C-xd":rleval -w cz -q find dir {0}'     # find dir under directory at cursor
bind -x '"\C-xD":rleval -w cz -q find dir . {0}'   # find dir matching word at cursor
bind -x '"\C-xf":rleval -w cz -q find file {0}'    # find file under directory at cursor
bind -x '"\C-xF":rleval -w cz -q find file . {0}'  # replace word at cursor with find file matching word at cursor
bind -x '"\C-xl":rleval -w cz -q locate {0}'       # replace word at cursor with name of file from locate database matching it
bind -x '"\C-xe":rleval -w cz -q grep {0}'         # replace word at cursor with name of selected file matching it
bind -x '"\C-xE":rleval -r cz -r grep {0}'         # edit the line matching the pattern at cursor
