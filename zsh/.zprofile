# This script shall be executed by Zsh after `.zshenv` when started as a login shell.
#
# man:zsh(1)


source "${XDG_CONFIG_HOME:-${HOME}/.config}/sh/login.sh"
