# This script shall be executed by Zsh when started as an interactive shell.
#
# man:zsh(1)


# Append to the history file instead of overwriting it.
#
# man:zshoptions(1)
setopt \
	-o \
	APPEND_HISTORY \
	#

# man:zshoptions(1)
# man:zshbuiltins(1)
setopt \
	-o \
	DEBUG_BEFORE_CMD \
	#

# Keep track of when each command was executed and how long it took in the history file.
#
# man:zshoptions(1)
setopt \
	-o \
	EXTENDED_HISTORY \
	#

# Acquire locks with `fcntl` when writing to the history file.
#
# man:zshoptions(1)
# man:fcntl(3p)
# man:fcntl(2)
setopt \
	-o \
	HIST_FCNTL_LOCK \
	#

# Forget any command that begins with a space character.
#
# man:zshoptions(1)
setopt \
	-o \
	HIST_IGNORE_SPACE \
	#

# Save each invoked command to the history file after the command finishes.
#
# man:zshoptions(1)
setopt \
	-o \
	INC_APPEND_HISTORY_TIME \
	#

# Expand escape sequences that start with '%' in prompt sequences like `PS1`.
#
# man:zshbuiltins(1)
# man:zshoptions(1)
# man:zshmisc(1)
setopt \
	-o \
	PROMPT_PERCENT \
	#

# Enable parameter expansion in prompt sequences like `PS1`.
#
# man:zshbuiltins(1)
# man:zshoptions(1)
setopt \
	-o \
	PROMPT_SUBST \
	#

function _chpwd_function_git
{
	_update_git_prompt
}

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

function _precmd_function_git
{
	if (( _must_update_git_prompt == 1 ))
	then
		_update_git_prompt
	fi
}

function _update_git_prompt
{
	if ! _git_branch="$(_get_git_branch)"
	then
		unset \
			-- \
			_git_branch \
			#
	fi
	_must_update_git_prompt=0
}

# man:zshmisc(1)
function TRAPDEBUG
{
	if [[ "${ZSH_DEBUG_CMD}" == git\ * ]]
	then
		_must_update_git_prompt=1
	fi
}

integer \
	-- \
	_must_update_git_prompt=1 \
	#

# Execute the function `_chpwd_function_git` "whenever the current working directory is changed".
#
# man:zshmisc(1)
chpwd_functions=(
	_chpwd_function_git
)

# Execute the function `_precmd_function_git` "before each prompt".
#
# man:zshmisc(1)
precmd_functions=(
	_precmd_function_git
)

# Scope variables not needed beyond this script to it.
#
# From the manual page:
#
# > The main use of anonymous functions is to provide a scope for local variables.
# > This is particularly convenient in start-up files as these do not provide their own local variable scope.
#
# man:zshmisc(1)
function
{
	local \
		-- \
		state_data_directory \
		this_script_directory_path \
		this_script_file_path \
		xdg_state_home \
		#

	integer \
		-- \
		maximum_value_32bit_integer \
		#

	# The maximum value that a 32-bit signed integer type may represent is 2 to the power of 31 minus 1.
	maximum_value_32bit_integer="$(( 2**31-1 ))"

	# Get a path to this script file.
	#
	# Without limits like the maximum path length, the maximum recursion depth and the maximum number of symbolic links followed in path resolution, there would be infinite different paths pointing to each file system object.
	# Even with those limits, there are many different paths pointing to each file system object.
	# For example, the path `foo/bar` points to the same file system object as `foo/./bar`, `foo/../foo/bar` and `foo/../foo/./bar`;
	# symbolic and hard links may result in even more different paths pointing to the same file system object.
	# The following code gets the path followed by Zsh to execute this script file.
	#
	# man:zshbuiltins(1)
	# man:zshmisc(1)
	print \
		-P \
		-v this_script_file_path \
		-- \
		%x \
		#

	# Get a path to a directory containing this script file.
	#
	# The following code gets the directory part of the path followed by Zsh to execute this script file.
	#
	# The following parameter expansion applies a modifier, `h`.
	# Such modifiers transform the result of parameter expansion:
	#
	# > After the optional word designator, you can add a sequence of one or more of the following modifiers, each preceded by a ‘:'.
	# > These modifiers also work on the result of filename generation and parameter expansion, except where noted.
	#
	# The modifier `h` "[r]emove[s] a trailing pathname component, shortening the path by one directory level".
	#
	# man:zshexpn(1)
	this_script_directory_path="${this_script_file_path:h}"

	# This is the directory designated by the XDG Base Directory specification to store user-specific state data such as the history file.
	#
	# https://specifications.freedesktop.org/basedir-spec/latest/
	xdg_state_home="${XDG_STATE_HOME:-${HOME}/.local/state}"

	state_data_directory="${xdg_state_home}/zsh"

	# Execute startup script for interactive POSIX shells.
	. \
		"${this_script_directory_path}/../sh/interactive.sh" \
		#

	# Create the directory for user-specific state data if it does not exist already.
	#
	# man:zshmisc(1)
	# man:mkdir(1p)
	if [[ ! -e "${state_data_directory}" ]]
	then
		mkdir \
			-p \
			-- \
			"${state_data_directory}" \
			#
	fi

	# Keep the history file in the directory designated by the XDG Base Directory specification for user-specific state data.
	#
	# man:zshparam(1)
	HISTFILE="${state_data_directory}/history"

	# Remember as many commands per session as the maximum value of a 32-bit signed integer type.
	#
	# Zsh likely uses either such a type or a larger one internally.
	#
	# man:zshparam(1)
	HISTSIZE="$((maximum_value_32bit_integer))"

	# Show the following information in the primary prompt:
	#
	# - the user's name (`%n`);
	# - whether Zsh is running "with privileges" (`%#`) in the primary prompt;
	# - the hostname (`%M`);
	# - the current working directory (`%d`); and
	# - the exit code of the last command (`${(l:3:)?}`), padded with spaces to the width of three characters.
	#
	# This information is split into two lines, with elements that may be long or whose length may vary in the first line.
	#
	# Zsh considers itself as running "with privileges" if "either the effective user ID is zero, or, if POSIX.1e capabilities are supported, […] at least one capability is raised in either the Effective or Inheritable capability vectors".
	#
	# man:zshparam(1)
	# man:zshmisc(1)
	# man:zshexpn(1)
	# man:strftime(3)
	PS1=$'%n@%M %d${_git_branch:+ ${_git_branch}}\n%D{%R} ${(l:3:)?} %# '

	# Keep as many commands in the history file as the maximum value of a 32-bit signed integer type.
	#
	# Zsh likely uses either such a type or a larger one internally.
	#
	# man:zshparam(1)
	SAVEHIST="$((maximum_value_32bit_integer))"
}
