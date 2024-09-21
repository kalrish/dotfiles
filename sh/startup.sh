# This script shall be executed by POSIX shells at startup.


# Have the AWS CLI load its "less sensitive configuration options" from a file in the directory designated by the XDG Base Directory specification for user-specific configuration files.
#
# https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files#cli-configure-files-where
# https://specifications.freedesktop.org/basedir-spec/latest/
AWS_CONFIG_FILE="${XDG_CONFIG_HOME:-${HOME}/.config}/aws/config.ini"

# Sign Debian packages with the OpenPGP key identified by the following fingerprint.
#
# man:debsign(1)
# man:dpkg-sig(1)
DEBSIGN_KEYID=E0C3497126B72CA47975FC322953BB8C16043B43

# Prevent changes to variables that are meant to stay set after this script is executed but should not be modified by accident.
readonly \
	-- \
	AWS_CONFIG_FILE \
	DEBSIGN_KEYID \
	#

export \
	-- \
	AWS_CONFIG_FILE \
	DEBSIGN_KEYID \
	#
