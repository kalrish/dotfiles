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

# Have the Kubernetes command line tool (`kubectl`) and other Kubernetes clients load both the default `${HOME}/.kube/config` and a kubeconfig file from the directory designated by the XDG Base Directory specification for user-specific configuration files, with the former having priority to allow for site-specific overrides.
#
# https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/
# https://specifications.freedesktop.org/basedir-spec/latest/
KUBECONFIG="${HOME}/.kube/config:${XDG_CONFIG_HOME:-${HOME}/.config}/k8s/config.yaml"

# Have the npm CLI load its user configuration from a file in the directory designated by the XDG Base Directory specification for user-specific configuration files.
#
# https://docs.npmjs.com/cli/v10/configuring-npm/npmrc
# https://docs.npmjs.com/cli/v10/using-npm/config#environment-variables
# https://specifications.freedesktop.org/basedir-spec/latest/
npm_config_userconfig="${XDG_CONFIG_HOME:-${HOME}/.config}/npm/npmrc"

# Prevent changes to variables that are meant to stay set after this script is executed but should not be modified by accident.
readonly \
	-- \
	AWS_CONFIG_FILE \
	DEBSIGN_KEYID \
	KUBECONFIG \
	npm_config_userconfig \
	#

export \
	-- \
	AWS_CONFIG_FILE \
	DEBSIGN_KEYID \
	KUBECONFIG \
	npm_config_userconfig \
	#
