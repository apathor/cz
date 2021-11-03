---
title: 'cz - Abstraction over line selection utilities - plus handy plugins!'
---

About
=====

Cz provides a common interface to interactive line selection tools.

Cz also acts as a framework for line selection based applications.

Included are over 200 plugins for common use cases. Out of the box you
can select from:

-   items from bash\'s built-in completion
-   files and directories
-   git branches
-   unicode characters
-   mpd tracks
-   pass(1) passwords
-   man pages and other documentation sources
-   elements from JSON/YAML/XML documents
-   docker images
-   system processes
-   i3 window manager components
-   terraform resources

And a whole lot more!

Tools
=====

Cz suports the following line selection tools:

-   \[dmenu\](<https://tools.suckless.org/dmenu>)
-   \[fzf\](<https://github.com/junegunn/fzf>)
-   \[fzy\](<https://github.com/jhawthorn/fzy>)
-   \[iselect\](<http://www.ossp.org/pkg/tool/iselect>)
-   \[pick\](<https://github.com/mptre/pick>)
-   \[pipedial\](<https://code.reversed.top/user/xaizek/pipedial>)
-   \[rofi\](<https://github.com/davatorium/rofi>)
-   \[selecta\](<https://github.com/garybernhardt/selecta>)
-   \[sentaku\](<https://github.com/rcmdnk/sentaku>)
-   \[slmenu\](<https://bitbucket.org/rafaelgg/slmenu>) (defunct?)
-   \[vis-menu\](<https://github.com/martanne/vis>)

THANKS to the authors of the above tools.

Installation
============

``` {.bash org-language="sh"}
# just download the script to a directory on your path
curl -sS https://raw.githubusercontent.com/apathor/cz/master/cz -o ~/bin/cz

# and make it executable
chmod +x ~/bin/cz
```

Cz requires at least bash version 4. Mac OS users should \`brew install
bash\`.

It is assumed that at least one of the line selection tools listed above
is also installed.

Usage
=====

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
      -q : quote    : Print fields extracted from the line.
      -r : run      : Run a templated command.
      -s : simulate : Print a templated command.
      -t : template : Print a templated string.
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

     These options determine line selection utility:
      -x            : Use a graphical line selection tool.
      -y            : Use a terminal line selection tool.
      -z TOOL       : Use the given line selection tool.

    TOOLS
     The following interactive line selection tools are supported:
     dmenu, fzf, fzy, iselect, pick, pipedial, rofi, selecta, sentaku, slmenu,
     and vis-menu.

    PLUGINS
     Plugins extend cz for an application specific task. Each defines input lines
      and options like the delimiter and templates.
     Run 'cz -l' to list plugins and 'cz -h PLUGIN' or 'cz help' for help text.
     All commands starting with 'cz_' are considered cz plugins.

    TEMPLATES
     Substrings of TEMPLATE in the following formats are replaced with
      one or more fields from a selected line split by DELIMITER.
         {X}     - field X
         {X:}    - fields X through end of fields
         {X:Y}   - fields X through X + Y
         {X,Y,Z} - fields X, Y, and Z

     Append @C, @E, @P, or @Q to transform selected fields:
      @C - Insert argument directly. This is risky for command strings!
      @E - Replace backslash escape sequences in arguments with bash $'...' quotes.
      @P - Expand arguments for use in prompt strings.
      @Q - Quote arguments for use in command input. This is the default.

    ENVIRONMENT
     CZ_GUI         : preferred interface - 1=graphical 0=terminal
     CZ_BINS_GUI    : list of graphical utilities in order of preference
     CZ_BINS_TTY    : list of terminal utilities in order of preference
     CZ_DMENU_COLOR : Colon separated colors for dmenu (NF:NB:SF:SB)

Configuration
=============

To get the most out of cz users should consider binding shell and window
manager keys.

Bash
----

Download this \[example bash config\](conf/cz.bashrc) then copy it into
your bashrc file.

The example config defines several key bindings that each insert text
into the shell\'s edit buffer.

-   C-x x : select a plugin, run it, and insert fields from the selected
    line
-   C-x X : select a plugin, run it, and insert the selected line
-   C-x z : select a plugin, run it, and insert templated command output
-   C-x Z : select a plguin, run it, and insert templated command string
-   C-x r : Select and insert a command from history
-   C-x u : select and insert a unicode character
-   C-x g : select an uncomitted file in current git repo and insert its
    path
-   C-x G : select a comitted file in current git repo and insert its
    path

Bash users should source cz to load included function \'rleval\'.

    rleval [OPTIONS] COMMAND [ARGS ...]
    Evaluate command then...
     -i : insert its output into the readline buffer at cursor point.
     -w : replace the word at cursor point with its output.
     -r : run the command attached to the terminal.

    The command string is templated using the current readline tokens.
    The word at cursor point is '{0}'. The first token in the command is '{1}' and so on.
    This function is intended to be used with the bash builtin 'bind -x'.

    EXAMPLES
     Insert the first token from the current readline buffer:
     $ bind -x '"\C-x0":rleval -i echo {1}'

     Insert fortunes on demand:
     $ bind -x '"\C-xf":rleval -i fortune"'

     Replace the current word with a generated password:
     $ bind -x '"\C-xp":rleval -w pwgen 20 1'

     Replace the current word with itself reversed:
     $ bind -x '"\C-xt":rleval -w "rev <<< {0}"'

     Encode and decode base64 strings at cursor point:
     $ bind -x '"\C-xb":rleval -w "base64 <<< {0}"'
     $ bind -x '"\C-xB":rleval -w "base64 -d <<< {0}"'

     Open the man page for the topic at cursor point:
     $ bind -x '"\C-xh":rleval -r man {0}'

Zsh
---

Download this \[example zsh config\](conf/cz.zshrc) then copy it into
your zshrc file.

The example config defines the same key bindings described in the bash
section above.

i3 Window Manager
-----------------

Download this \[example i3 config\](conf/cz-i3.conf) then copy it into
your i3 config.

The example config defines the following key bindings:

-   Mod-x : select a plugin, run it, and put fields from selected line
    into a clipboard
-   Mod-X : select a plugin, run it, and put selected line into a
    clipboard
-   Mod-z : select a plugin, run it, and put command output into a
    clipboard
-   Mod-Z : select a plguin, run it, and put command string into a
    clipboard
-   Mod-c : select a command and run it
-   Mod-C : select a clipboard and pipe its contents through the
    selected command
-   Mod-o : select a clipboard then select from URLs extracted from its
    contents to open in a browser
-   Mod-Shift-Space : select an i3 a tag and jump to the selected window
-   Mod-Tab : select an i3 window and jump to it
-   Mod-Shift-Tab : select an i3 workspace and switch to it

Plugins
=======

Cz considers any command starting with \'cz\_\' a valid plugin.

Plugins should:

-   print usage text if the CZ\_HELP environment variable is non-empty
-   provide some application specific input to cz
-   run cz with application specific options (-d, -e, -f, -i)
-   run cz without setting one of the mode options (-p, -q, -r, -s, -t,
    -u)

Example - bash function
-----------------------

A function like the following can be defined in your bash configuration:

``` {.bash org-language="sh"}
cz_fruit() {
  if [ -n "$CZ_HELP" ]; then
    printf "cz fruit\nSelect a fruit\n" >&2
    return 0
  fi
  cz -e 'printf "Go %s!\n" {0}' \
    -i <(printf "%s\n" apple banana grapefruit orange)
}

```

Example - external program
--------------------------

Use your favorite language! Put the following in a file called
\'cz\_twos\' on your path:

``` {.perl}
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

Name
====

``` {.text}
seize
To fall or rush upon suddenly and lay hold of; to gripe or grasp suddenly;
*to reach and grasp*.
```
