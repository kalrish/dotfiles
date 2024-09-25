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

	# Keep as many commands in the history file as the maximum value of a 32-bit signed integer type.
	#
	# Zsh likely uses either such a type or a larger one internally.
	#
	# man:zshparam(1)
	SAVEHIST="$((maximum_value_32bit_integer))"
}
