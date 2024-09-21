# This script shall be executed by Bash when started as an interactive shell.
#
# info:(bash)Interactive_Shells


# Execute startup script for interactive POSIX shells.
#
# https://specifications.freedesktop.org/basedir-spec/latest/
source \
	-- \
	"${XDG_CONFIG_HOME:-${HOME}/.config}/sh/interactive.sh" \
	#

# Append to the history file instead of overwriting it.
#
# info:(bash)The_Shopt_Builtin
# info:(bash)Bash_History_Facilities
shopt \
	-s \
	-- \
	histappend \
	#

_exit_code_padding='   '

# Save every command that does not begin with a space character in the history list.
#
# info:(bash)Bash_Variables
# info:(bash)Bash_History_Facilities
HISTCONTROL=ignorespace

# Keep the history file in the directory designated by the XDG Base Directory specification for user-specific state data.
#
# info:(bash)Bash_Variables
# info:(bash)Bash_History_Facilities
# https://specifications.freedesktop.org/basedir-spec/latest/
HISTFILE="${XDG_STATE_HOME:-${HOME}/.local/state}/bash/history"

# Let the history file grow indefinitely.
#
# info:(bash)Bash_Variables
# info:(bash)Bash_History_Facilities
HISTFILESIZE=-1

# Let the in-memory history list grow indefinitely.
#
# info:(bash)Bash_Variables
# info:(bash)Bash_History_Facilities
HISTSIZE=-1

# Keep track of when each command was executed in the history file.
# Display dates in history listings according to ISO 8061.
#
# info:(bash)Bash_Variables
# info:(bash)Bash_History_Facilities
# man:strftime(3)
HISTTIMEFORMAT='%FT%T%z '

# Show the following information in the primary prompt:
#
# - the user's name (`\u`);
# - whether they are root (`\$`);
# - the hostname (`\H`);
# - the current working directory (`\w`);
# - the time in 24-hour HH:MM format (`\A`); and
# - the exit code of the last command (`${?}`), padded with spaces to the width of three characters.
#
# This information is split into two lines, with elements that may be long, such as the hostname, or whose length may vary, such as the working directory, in the first line.
#
# info:(bash)Bourne_Shell_Variables
# info:(bash)Controlling_the_Prompt
# info:(bash)Interactive_Shell_Behavior
# info:(bash)Shell_Parameter_Expansion
# info:(bash)Special_Parameters
PS1='\u@\H \w\n\A ${_exit_code_padding:${#?}}${?} \$ '

# Prevent changes to variables that:
#
# - are supposed to stay set, either because they are needed or because they have some effect on the shell; and
# - should not be modified; but
# - were not marked read-only already.
readonly \
	-- \
	HISTCONTROL \
	HISTFILE \
	HISTFILESIZE \
	HISTSIZE \
	HISTTIMEFORMAT \
	PS1 \
	_exit_code_padding \
	#
