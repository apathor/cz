![cz example gif](/web/cz-ex1.gif)

Cz provides a common interface to interactive line selection tools.

Cz also acts as an extensible framework for line selection based applications.

Included are 160 plugins for common use cases. Out of the box you can select from:

 - everything from bash's built-in completion
 - files and directories
 - git branches
 - unicode characters
 - mpd tracks
 - pass(1) passwords
 - man pages and other documentation sources
 - elements from JSON/YAML/XML documents
 - docker images
 - system processes
 - i3 window manager components

And a whole lot more!

# Tools

Cz suports the following line selection tools:
 - [dmenu](https://tools.suckless.org/dmenu)
 - [fzf](https://github.com/junegunn/fzf)
 - [iselect](http://www.ossp.org/pkg/tool/iselect)
 - [pick](https://github.com/mptre/pick)
 - [pipedial](https://code.reversed.top/user/xaizek/pipedial)
 - [rofi](https://github.com/davatorium/rofi)
 - [sentaku](https://github.com/rcmdnk/sentaku)
 - [slmenu](https://bitbucket.org/rafaelgg/slmenu)
 - [vis-menu](https://github.com/martanne/vis)

## Installation

```sh
# just download the script to a directory on your path
curl -sS https://raw.githubusercontent.com/apathor/cz/master/cz -o ~/bin/cz

# and make it executable
chmod +x ~/bin/cz

```

Cz requires at least bash version 4. Mac OS users should `brew install bash`.

It is assumed that at least one of the line selection tools listed above is also installed.

## Usage

```
cz [OPTIONS] < LINES
Select a line from input with an appropriate tool.

cz [OPTIONS] [PLUGIN] [ARGS ...]
Run a plugin to select something application specific.

OPTIONS
 These options print some information and exit:
  -h : help     : Print this help text or help text for plugin.
  -k : tools    : List supported line selection tools.
  -l : plugins  : List detected plugins.
  -v : version  : Print version string.

 These options set program mode. Select a line then...
  -p : print    : Print the line. This is the default mode.
  -q : quote    : Print extracted FIELDS from the line.
  -r : run      : Run the string formatted by TEMPLATE using fields from the line.
  -s : simulate : Print the string formatted by TEMPLATE using fields from the line.

 General options:
  -d DELIMITER  : Set delimiter to split selected line.
  -e TEMPLATE   : Set command template. This option implies mode '-r'.
  -f FIELDS     : Set field template. This option implies mode '-q'.
  -i IN-FILE    : Set file from which to read selections instead of stdin.
  -x            : Use a graphical line selection tool.
  -y            : Use a text terminal line selection tool.
  -z TOOL       : Use the given line selection tool.
  -0            : Read null terminated lines from input.

TEMPLATES
 Substrings of TEMPLATE in the following formats are replaced with
  one or more fields from a selected line split by DELIM.
     {X}     - field X
     {X:}    - fields X through end of fields
     {X:Y}   - fields X through X + Y
     {X,Y,Z} - fields X, Y, and Z
 FIELDS consists of one of the above without the enclosing '{}'.

ENVIRONMENT
 CZ_GUI         : preferred interface - 1=graphical 0=terminal
 CZ_BINS_GUI    : list of graphical utilities in order of preference
 CZ_BINS_TTY    : list of terminal utilities in order of preference
 CZ_DMENU_COLOR : Colon separated colors for dmenu (NF:NB:SF:SB)

```

## Configuration

To get the most out of cz users should consider binding shell and window manager keys.

### Bash

Bash users can source cz to load two functions useful for key bindings:

 - rleval : insert the output of a command at cursor point in the readline buffer
 - rlword : replace the word under the cursor in the readline buffer with the output of a command

Add the following to ~/.bashrc to configure key bindings that provide an interface to all plugins:
```sh
# source cz to enable completion and extra functions
. cz

# use only terminal line selection tools in the shell
export CZ_GUI=0

# select a plugin, run it and insert a relevant field from the selected line
bind -x '"\C-xx":rleval "cz meta -q"'

# select a plugin, run it and insert the whole selected line
bind -x '"\C-xX":rleval "cz meta -p"'

# select a plugin, run it and insert the output of its command
bind -x '"\C-xz":rleval "cz meta -r"'

# select a plugin, run it and insert its command string
bind -x '"\C-xZ":rleval "cz meta -s"'

```

Here are some narrower examples:
```sh
# insert selected path to file under current directory
bind -x '"\C-xf":rleval "cz find file"'

# change working directory to selected apparix bookmark
bind -x '"\C-xa":cz -e "cd {1}" apparix'

# select a process and kill it
bind -x '"\C-xk":cz -r kill'

# insert selected bash history entry
bind -x '"\C-xr":rleval "cz -q bash history"'

# insert selected word from recent bash history
bind -x '"\C-xw":rleval "cz word < <(HISTTIMEFORMAT=\"\" history 1000)"'

# insert selected unicode character
bind -x '"\C-xu":rleval "cz -q unicode"'

# insert selected modified file from the git repository in the current directory
bind -x '"\C-xg":rleval "cz -q git status"'

# insert selected file held by the git repository in the current directory
bind -x '"\C-xG":rleval "cz -q git file"'

# ssh into the selected host
bind -x '"\C-xh":stty sane; cz -r ssh; stty sane'

# play selected track from the mpd playlist
bind -x '"\C-xm":cz -r mpd track'
```

### i3 Window Manager

```
# i3 specific plugins
bindsym $mod+space        exec i3-input -F 'mark %s' 1 -P 'Mark: '
bindsym $mod+Shift+space  exec "cz i3 mark"
bindsym $mod+Tab          exec "cz i3 window"
bindsym $mod+Shift+Tab    exec "cz i3 workspace"

# put cz output for any plugin onto a clipboard
bindsym $mod+z            exec "cz meta -r | cz xclip in"
bindsym $mod+Shift+z      exec "cz meta -s | cz xclip in"
bindsym $mod+x            exec "cz meta -q | cz xclip in"
bindsym $mod+Shift+x      exec "cz meta -p | cz xclip in"

# run selected command
bindsym $mod+c            exec "cz command"

# pipe the contents of a clipboard through selected command
bindsym $mod+Shift+c      exec "cz xclip out | cz command | cz xclip in"

# browse to selected URI extracted from a clipboard
bindsym $mod+o            exec "cz xclip out | cz -r uri"

# put a password from a password manager onto a clipboard
bindsym $mod+p            exec "cz pass | cz xclip in"

```

## Plugins

Cz considers any command starting with 'cz_' a valid plugin.
Plugins should:
 - print usage text if the CZ_HELP environment variable is non-empty
 - provide some application specific input to cz
 - run cz with application specific options (-d, -e, -f, -i)
 - run cz without setting one of the mode options (-p, -q, -r, -s)

### Example - bash function

A function like the following can be defined in your bash configuration:

```sh
cz_fruit() {
  if [ -n "$CZ_HELP" ]; then
    printf "cz fruit\nSelect a fruit\n"
    return 0
  fi
  cz -e 'printf "Go %s!\n" {0}' \
    -i <(printf "%s\n" apple banana grapefruit orange)
}

```

### Example - external program

Use your favorite language! Put the following in a file called 'cz_twos' on your path:

```perl
#!/usr/bin/env perl
use strict;
use warnings;

if($ENV{"CZ_HELP"}) {
  print "cz twos\nSelect from powers of two.";
  return 0;
}

open(my $pipe, "|-", "cz -f 1");
print $pipe $_ for map { sprintf "%d\t%d\n", $_, 2 ** $_ } (1..32);
close($pipe);

```
