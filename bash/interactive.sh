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
