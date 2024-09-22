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

# Prevent changes to variables that:
#
# - are supposed to stay set, either because they are needed or because they have some effect on the shell; and
# - should not be modified; but
# - were not marked read-only already.
readonly \
	-- \
	HISTFILESIZE \
	HISTSIZE \
	HISTTIMEFORMAT \
	#
