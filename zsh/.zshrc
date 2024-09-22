# This script shall be executed by Zsh when started as an interactive shell.
#
# man:zsh(1)


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
		this_script_directory_path \
		this_script_file_path \
		#

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

	# Execute startup script for interactive POSIX shells.
	. \
		"${this_script_directory_path}/../sh/interactive.sh" \
		#
}
