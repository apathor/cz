![cz example gif](/web/cz-ex1.gif)

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
