# cz

## About

Cz is a bash script that provides a common interface to interactive line
selection tools.

What is an "interactive line selection tool"? It's a kind of program
that reads text input then presents an interactive menu for the user to
select one line.

Some line selection tools run only in the terminal and others are
graphical - cz uses a tool appropriate for the situation.

Cz also acts as a framework for pluggable line selection based
applications. Included are over 250 plugins covering a variety of use
cases. For example:

  - items from [bash's built-in
    completion](https://www.gnu.org/software/bash/manual/bash.html#Programmable-Completion-Builtins-1)
  - [Git](https://git-scm.com/) branches, commits, tags, etc.
  - [Unicode](https://home.unicode.org/) characters
  - [pass(1)](https://www.passwordstore.org/) passwords
  - elements from
    [JSON](https://www.json.org/)/[YAML](http://yaml.org/)/[XML](https://www.w3.org/XML/)
    documents
  - [Docker](https://www.docker.com/)
  - [i3 window manager](https://i3wm.org/) components
  - [Terraform](https://www.terraform.io/) elements
  - [Mpd](https://www.musicpd.org/) tracks and tags
  - [Systemd](https://systemd.io/) units
  - [Tmux](https://github.com/tmux/tmux) components

And a whole lot more\!

## Tools

The following line selection tools are
    supported:

  - [choose](https://github.com/chipsenkbeil/choose)
  - [dmenu](https://tools.suckless.org/dmenu)
  - [fzf](https://github.com/junegunn/fzf)
  - [fzy](https://github.com/jhawthorn/fzy)
  - [iselect](http://www.ossp.org/pkg/tool/iselect)
  - [pick](https://github.com/mptre/pick)
  - [pipedial](https://code.reversed.top/user/xaizek/pipedial)
  - [rofi](https://github.com/davatorium/rofi)
  - [selecta](https://github.com/garybernhardt/selecta)
  - [sentaku](https://github.com/rcmdnk/sentaku)
  - [shuf](https://www.gnu.org/software/coreutils/manual/html_node/shuf-invocation.html)
  - [slmenu](https://github.com/joshaw/slmenu)
  - [vis-menu](https://github.com/martanne/vis)

Many thanks to the authors of the above tools\!

## Installation

``` bash
# just download the script to a directory on your path
curl -sS https://raw.githubusercontent.com/apathor/cz/master/cz -o ~/bin/cz

# and make it executable
chmod +x ~/bin/cz
```

Cz requires at least bash version 4. Mac OS users should \`brew install
bash\`.

## Usage

    cz [OPTIONS] [PLUGIN...] [ARGS ...] [< LINES]
    Select a line using your preferred interactive line selection tool.
    
    OPTIONS
     These options print some information and exit:
      -h : help     : Show this help text or help text for plugin.
      -H : example  : List example commands.
      -k : tools    : List supported line selection tools.
      -l : plugins  : List detected plugins.
      -v : version  : Show version string.
    
     These options set the program mode. Select a line then... :
      -p : print    : Print the line. This is the default mode.
      -q : quoted   : Print fields from the line in shell quotes.
      -r : run      : Run a templated command.
      -s : simulate : Print a templated command.
      -t : template : Print a templated string.
      -u : unquoted : Print fields from the line literally.
      -o :          : Only print input lines instead of selecting a line.
    
     These options set a template:
      -e TEMPLATE   : Set the command template. This option implies mode '-r'.
      -f FIELDS     : Set the field template. This option implies mode '-q'.
    
     These options control input and line splitting:
      -c            : Do not use cached input lines.
      -d DELIMITER  : Set the field splitting characters.
      -g            : Buffer stdin and pass it to command set with '-e'.
      -0            : Read null terminated lines from input.
      -i IN-FILE    : Set file from which to read selections instead of stdin.
    
     These options control which line selection utility is used:
      -x            : Use a graphical line selection tool.
      -y            : Use a terminal line selection tool.
      -z TOOL       : Use the given line selection tool.
    
    TOOLS
     The following interactive line selection tools are supported:
      choose, dmenu, fzf, fzy, iselect, pick, pipedial, rofi, selecta, sentaku,
      slmenu, and vis-menu.
    
    PLUGINS
     Plugins use cz for an application specific task. Each plugin defines input
      lines and options like the delimiter and templates.
     Run 'cz -l' to list plugins and 'cz -h PLUGIN' or 'cz help' for help text.
     All commands starting with 'cz_' are considered plugins.
    
    TEMPLATES
     Sub-strings of TEMPLATE in the following formats are replaced with
      one or more fields from a selected line split by DELIMITER.
         {X}     - field X
         {X:}    - fields X through end of fields
         {X:Y}   - fields X through X + Y
         {X,Y,Z} - fields X, Y, and Z
    
     Append @C, @E, @P, or @Q to transform selected fields:
      {X@C} - Insert argument directly. This is risky for command strings!
      {X@E} - Replace backslash escape sequences in arguments with bash $'...' quotes.
      {X@P} - Expand arguments for use in prompt strings.
      {X@Q} - Quote arguments for use in command input. This is the default.
    
    ENVIRONMENT
     CZ_GUI         : The preferred interface (1=graphical 0=terminal).
     CZ_BINS        : A list of line selection tools in order of preference.
     CZ_DMENU_COLOR : Colon separated colors for dmenu (NF:NB:SF:SB).
     CZ_DMENU_FONT  : The font to use for dmenu.
     CZ_ROFI_THEME  : The theme to use for rofi.

## Configuration

To get the most out of cz users should consider binding shell and window
manager keys.

### Bash

Download this \[example bash config\](conf/cz.bashrc) then copy it into
your bashrc file.

The example config defines key bindings that run cz to provide
interactive functionality.

Some of the key bindings use the included function \`reval\` to do one
of the following:

  - Insert output from cz into the bash command buffer at cursor point.
  - Replace the word at cursor point in the bash command buffer with
    output from cz.
  - Run cz to launch an interactive program (like $EDITOR) using some
    part of the selection.

The example key bindings are as follows:

  - C-x x : Select a cz plugin, run it in quote mode, and insert one or
    more fields from the selection.
  - C-x X : Select a cz plugin, run it print mode, and insert the
    selection.
  - C-x z : Select a cz plugin, run it in run mode, and insert the
    output of the command.
  - C-x Z : Select a cz plguin, run it in simulate mode and insert the
    command templated with the selection.
  - C-x r : Select a command from bash history and insert it.
  - C-x u : Select a unicode character and insert it.
  - C-x g : Select an uncomitted file in current git repository and
    insert its path.
  - C-x G : Select a comitted file in current git repository and insert
    its path.
  - C-x d : Using the current word as a directory, replace it with a
    selected descendant directory.
  - C-x D : Using the current word as a pattern, replace it with a
    selected matching descendant directory under $PWD.
  - C-x f : Using the current word as a directory, replace it with a
    selected descendant file.
  - C-x F : Using the current word as a pattern, replace it with a
    selected matching descendant file under $PWD.
  - C-x l : Using the current word as a pattern, replace it with a
    selected matching file from the locate database.
  - C-x e : Using the current word as a pattern, replace it with the
    path of a file matching it under $PWD.
  - C-x E : Using the current word as a pattern, run $EDITOR to open
    selected file matching it under $PWD.

### Zsh

Download the example zsh config then copy it into your zshrc file.

The example config defines the same key bindings described in the bash
section above.

### i3 Window Manager

Download the example i3 config then copy it into your i3 config.

The example config defines the following key bindings:

  - Mod-x : Select a cz plugin, run it, and put fields from selected
    line into a clipboard
  - Mod-X : Select a cz plugin, run it, and put selected line into a
    clipboard
  - Mod-z : Select a cz plugin, run it in , and put command output into
    a clipboard
  - Mod-Z : Select a cz plguin, run it in simulate mode, and put the
    output into a clipboard
  - Mod-c : Select a command and run it
  - Mod-C : Select a clipboard and pipe its contents through the
    selected command
  - Mod-o : Select a clipboard then select a URL extracted from its
    contents to open in a browser
  - Mod-Shift-Space : Select an i3 a tag and jump to the selected window
  - Mod-Tab : Select an i3 window and jump to it
  - Mod-Shift-Tab : Select an i3 workspace and switch to it

## Plugins

Cz considers any command starting with 'cz\_' a valid plugin.

Plugins should:

  - print usage text if the CZ\_HELP environment variable is non-empty
  - provide some application specific input to cz
  - run cz with application specific options (-d, -e, -f, -i)
  - run cz without setting one of the mode options (-p, -q, -r, -s, -t,
    -u)

### Example - bash function

A function like the following can be defined in your bash configuration:

``` bash
cz_fruit() {
  if [ -n "$CZ_HELP" ]; then
    printf "cz fruit\nSelect a fruit\n" >&2
    return 0
  fi
  cz -e 'printf "Go %s!\n" {0}' \
    -i <(printf "%s\n" apple banana grapefruit orange)
}

```

### Example - external program

Use your favorite language\! Put the following in a file called
'cz\_twos' on your path:

``` perl
#!/usr/bin/env perl
use strict;
use warnings;

if($ENV{"CZ_HELP"}) {
  print STDERR "cz twos\nSelect from powers of two.\n";
  exit 0;
}

open(my $pipe, "|-", "cz -f 1");
print $pipe $_ for map { sprintf "%d %d\n", $_, 2 ** $_ } (1..32);
close($pipe);
```

## Name

``` text
seize
To fall or rush upon suddenly and lay hold of; to gripe or grasp suddenly;
*to reach and grasp*.
```
