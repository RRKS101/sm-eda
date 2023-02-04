# sm-eda
Aims to provide a more convenient approach to creating logic circuits in the game scrap mechanic.
Currently limited to command-line actions ___FOR WINDOWS___.

## Commands
__exit__ or __quit__ or __q__
Exits the program

__clear__
Writes the ANSI code to clear the terminal. 
_If your terminal does not support it, you will need to fix this yourself_

__reload__
Reloads all files in src/cmds/
_This is a terrible piece of code as it is dependent on Windows `dir` command. This should be easy enough to port by changing the command to a `find`-based derivative_

__load__
This is a command that is loaded from src/cmds/load.lua
Takes one argument corresponding to the path+file for blueprint.json found in scrap mechanic blueprints

__save__
This is a command that is loaded from src/cmds/save.lua
Takes zero-one arguments, with its behaviour changing depending.
Should no arguments be provided, it will overwrite the blueprint that is currently loaded (or error if there is none)
If an argument is provided, it will correspond to the path+file and will save there

__select__
This is a command that is loaded from src/cmds/select.lua
This is a complex command that is used to filter what blocks are currently selected and has a few sub-commands
_Please note that most fields have not been implemented_
If the provided value is NOT a sub-command, then it is treated as a field to use when searching. These fields are hard-coded via if-else blocks in order to reduce some inconveniences that are present in the structure of a scrap mechanic blueprint
Otherwise it will check if it is a subcommand such as the following;
 - __clear__ or __reset__ or __all__
    Adds all blocks to the selection
 - __none__
    Removes all blocks from the selection
 - __log__ or __print__
    writes the json data from all blocks that are selected. If followed by pretty or p, then it will use `json:encode_pretty` to produce the text rather than `json:encode`

Currently the only fields implemented are color/colour which supports comparing individual channels of rgb or as a whole
The filter can use ==,!=,>,>=,< and <= to compare both rgb and rgb channels. 
When performing a comparason on all channels, i.e; rgb, it will act like a 3D-vector comparason, where it is only greater if all channels are true, otherwise it is false and will be removed from the selection

Its worth noting that the selection by default selects all blocks and will _exclude_ blocks as they fail to meet selection criteria. 
Additionally, running multiple selection commands after one another will _not_ reset the selection but rather refine it, i.e; only blocks that meet `select ...` AND `select ....` will remain selected.

Currently no command to modify these fields exists.
