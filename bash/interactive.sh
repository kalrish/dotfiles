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
