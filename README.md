<!--
	SPDX-FileCopyrightText: © 2025 David Joaquín Shourabi Porcel <https://www.djsp.eu/>
	SPDX-License-Identifier: AGPL-3.0-only
-->


# personal configuration

This repository contains my personal configuration.

## installation

### systems that implement the XDG Base Directory Specification

On systems that implement the [XDG Base Directory Specification][], check out this repository at the path denoted by the environment variable `XDG_CONFIG_HOME`, if that environment variable is set, or `${HOME}/.config`, where `${HOME}` stands for the value of the environment variable `HOME`.
Do so by executing the following command with a [POSIX shell][]:

```Shell
git clone -- https://codeberg.org/djsp/dotfiles.git "${XDG_CONFIG_HOME:-${HOME}/.config}"
```


[POSIX shell]: https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html
[XDG Base Directory Specification]: https://specifications.freedesktop.org/basedir-spec/latest/
