# Bash Cz Config

. cz

# Disable graphical line selection for the shell
export CZ_GUI=0

# Set rofi theme
# export CZ_ROFI_THEME="solarized"

# Set dmenu font
# export CZ_DMENU_FONT="Unifont:normal:pixelsize=14"

# Core Functionality
bind -x '"\C-xx":rleval cz meta -q'                 # insert cz plugin selection at cursor
bind -x '"\C-xX":rleval cz meta -p'                 # insert cz plugin line at cursor
bind -x '"\C-xz":rleval cz meta -r'                 # insert cz plugin command output at cursor
bind -x '"\C-xZ":rleval cz meta -s'                 # insert cz plugin command string at cursor
bind -x '"\C-xc":cz meta -r'                        # just run cz plugin in command mode

# Shell Utilities
bind -x '"\C-xr":rleval -i cz -q bash history {0}'  # insert selected line from bash history matching current word at cursor
bind -x '"\C-x!":rleval -i cz -q argv {0:}'         # insert word selected from current readline buffer at cursor
bind -x '"\C-xu":rleval -i cz -u unicode character' # insert selected unicode character at cursor
bind -x '"\C-xU":rleval -i cz -u unicode symbol'    # insert selected unicode symbol at cursor
bind -x '"\C-x,":rleval -w cz -q whence {0}'        # replace word under cursor with matching command path

# Directory Navigation
bind -x '"\C-x<":cz -re "cd {0}" ancestor'          # cd to ancestory directory
bind -x '"\C-x>":cz -re "cd {0}" descendant'        # cd to descendant directory

# Git
bind -x '"\C-xg":rleval cz -q git status'           # insert path of selected modified file at cursor
bind -x '"\C-xG":rleval cz -q git file'             # insert path of selected git tracked file at cursor

# File Lookup
bind -x '"\C-xd":rleval -w cz -q find dir {0}'      # find dir under directory at cursor
bind -x '"\C-xD":rleval -w cz -q find dir . {0}'    # find dir matching word at cursor
bind -x '"\C-xf":rleval -w cz -q find file {0}'     # find file under directory at cursor
bind -x '"\C-xF":rleval -w cz -q find file . {0}'   # replace word at cursor with find file matching word at cursor
bind -x '"\C-xl":rleval -w cz -q locate {0}'        # replace word at cursor with name of file from locate database matching it
bind -x '"\C-xe":rleval -w cz -q grep {0}'          # replace word at cursor with name of selected file matching it
bind -x '"\C-xE":rleval -r cz -r grep {0}'          # edit the line matching the pattern at cursor
