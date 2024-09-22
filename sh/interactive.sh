# This script shall be executed by POSIX shells when started in interactive mode.


# Prevent accidental termination with Ctrl-D.
#
# Ctrl-D is used in at least one application: Google Meet, where it mutes and unmutes one's audio input.
# Sometimes, the focus is unknowingly on the terminal window and the keystroke gets sent to it, terminating the interactive shell session it ran.
#
# man:set(1p)
set \
	-o ignoreeof \
	#

_qless ()
{
	"${1}" \
		. \
		-- \
		${2+"${2}"} \
	|
	"${PAGER:-less}"
}

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

if command_available jq
then
	alias jqless='_qless jq'
fi
if command_available yq
then
	alias yqless='_qless yq'
fi

export \
	-- \
	INPUTRC \
	#
