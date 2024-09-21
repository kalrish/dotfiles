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

function _check_directory
{
	if [[ "${PWD}" != "${_last_working_directory}" ]]
	then
		# The shell changed to a different directory.

		_last_working_directory="${PWD}"

		# The new working directory might be inside the work tree of a git repository.
		_must_update_git_prompt=1
	fi
} &> /dev/null

function _get_git_branch
{
	# man:git-rev-parse(1)
	git \
		rev-parse \
		--symbolic-full-name \
		--abbrev-ref \
		HEAD \
		#
} 2> /dev/null

function _trap_debug
{
	if [[ ${BASH_COMMAND} == git\ * ]]
	then
		# The next command starts with `git `, so it might check out a different branch.
		_must_update_git_prompt=1
	fi
} &> /dev/null

function _update_git_prompt
{
	if (( _must_update_git_prompt == 1 ))
	then
		if ! _git_branch="$(_get_git_branch)"
		then
			unset \
				-- \
				_git_branch \
				#
		fi
		_must_update_git_prompt=0
	fi
} &> /dev/null

readonly \
	-f \
	-- \
	_check_directory \
	_get_git_branch \
	_trap_debug \
	_update_git_prompt \
	#

declare \
	-i \
	-- \
	_must_update_git_prompt \
	#
_exit_code_padding='   '
_must_update_git_prompt=1

# Give them nice names.
#
# man:tput(1p)
# man:tput(1)
_term_color_foreground_blue="$(tput -- setaf 4)"
_term_color_foreground_green="$(tput -- setaf 2)"
_term_color_foreground_orange="$(tput -- setaf 208)"
_term_reset="$(tput -- sgr0)"

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

# Execute the functions named in the following indexed array before the primary prompt (`PS1`) is displayed.
#
# info:(bash)Bash_Variables
# info:(bash)Controlling_the_Prompt
# info:(bash)Interactive_Shell_Behavior
PROMPT_COMMAND=(
	_check_directory
	_update_git_prompt
)

# Show the following information in the primary prompt:
#
# - the user's name (`\u`);
# - whether they are root (`\$`);
# - the hostname (`\H`);
# - the current working directory (`\w`);
# - the name of the checked out git branch (`${_git_branch}`), if any;
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
PS1="\\[${_term_color_foreground_green}\\]\\u@\\H\\[${_term_reset}\\] \\[${_term_color_foreground_blue}\\]\\w\\[${_term_reset}\\]\${_git_branch:+ \${_git_branch}}\\n\\[${_term_color_foreground_orange}\\]\\A\\[${_term_reset}\\] \${_exit_code_padding:\${#?}}\${?} \\[${_term_color_foreground_blue}\\]\\\$\\[${_term_reset}\\] "

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

# Unset variables that aren't needed anymore.
unset \
	-v \
	-- \
	_term_color_foreground_blue \
	_term_color_foreground_green \
	_term_color_foreground_orange \
	_term_reset \
	#

# Execute the function `_trap_debug` before every command.
trap \
	-- \
	_trap_debug \
	DEBUG \
	#
