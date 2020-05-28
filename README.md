![cz example gif](/web/cz-ex1.gif)

Cz is a bash script that provides a common interface to various interactive line selection tools.
It also acts as an extensible framework for small selection based applications.

Cz comes with 150+ plugins for common use cases. Out of the box you can select from:

 - files and directories
 - git branches
 - unicode characters
 - mpd tracks
 - everything from bash's built-in completion
 - pass(1) passwords
 - man pages and other documentation sources
 - JSON/XML elements
 - docker images
 - system processes

And a whole lot more!

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
     {X}     - argument X
     {X:}    - arguments X through end of arguments
     {X:Y}   - arguments X through X + Y
     {X,Y,Z} - arguments X, Y, and Z
 FIELDS consists of one of the above without the enclosing '{}'.

ENVIRONMENT
 CZ_GUI         : preferred interface - 1=graphical 0=terminal
 CZ_BINS_GUI    : list of graphical utilities in order of preference
 CZ_BINS_TTY    : list of terminal utilities in order of preference
 CZ_DMENU_COLOR : Colon separated colors for dmenu (NF:NB:SF:SB)

TOOLS
 Supported line selection tools are dmenu, fzf, iselect, pick,
  pipedial, rofi, sentaku, slmenu, and vis-menu.

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
  if [ -n "$CZ_HOME" ]; then
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
use IPC::Run3;

if($ENV{"CZ_HOME"}) {
  print "cz twos\nSelect from powers of two.\n";
  return 0;
}
my @twos = map { sprintf "%d\t%d\n", $_, 2 ** $_ } (1..32);
run3 [qw/cz -f 1/], \@twos;

```
