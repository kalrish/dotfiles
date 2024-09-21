# This script shall be executed by POSIX shells when started in interactive mode.


# Have the GNU Readline library load its initialization file from the directory designated by the XDG Base Directory specification for user-specific configuration files.
#
# man:readline(3)
# https://specifications.freedesktop.org/basedir-spec/latest/
INPUTRC="${XDG_CONFIG_HOME:-${HOME}/.config}/readline/inputrc"

# Prevent changes to variables that are meant to stay set after this script is executed but should not be modified.
readonly \
	-- \
	INPUTRC \
	#

export \
	-- \
	INPUTRC \
	#
