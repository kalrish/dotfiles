# This script shall be executed at startup by any POSIX shell that is invoked as a login shell.


# Export locale variables set in `${XDG_CONFIG_HOME}/locale.conf`.
#
# User locale preferences are best encoded as part of [JSON user records][].
# Users defined in `/etc/passwd` require a different solution.
# Without a user record manager, the solution depends on the login application.
# In Arch Linux, `/etc/profile` executes `/etc/profile.d/locale.sh` and `/etc/profile.d/locale.sh`, in turn, executes `${XDG_CONFIG_HOME}/locale.conf` and exports the locale variables set therein.
# The following code implements that mechanism at the user level, extending it to all distributions.
#
# man:locale(7)
# https://specifications.freedesktop.org/basedir-spec/latest/
# https://systemd.io/USER_RECORD
. \
	-- \
	"${XDG_CONFIG_HOME:-${HOME}/.config}/locale.conf" \
	#
export \
	-- \
	LANG \
	LANGUAGE \
	LC_ADDRESS \
	LC_COLLATE \
	LC_CTYPE \
	LC_IDENTIFICATION \
	LC_MEASUREMENT \
	LC_MESSAGES \
	LC_MONETARY \
	LC_NAME \
	LC_NUMERIC \
	LC_PAPER \
	LC_TELEPHONE \
	LC_TIME \
	#
