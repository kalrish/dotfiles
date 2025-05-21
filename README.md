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

### Windows

On Windows, check out this repository by executing the following command with [cmd.exe][]:

```Batchfile
git -c core.autocrlf=false clone -- https://codeberg.org/djsp/dotfiles.git "%USERPROFILE%/.config"
```

## other applications

My personal configuration for some applications is in separate repositories:

- [command-line shells][command-line shell]: [`djsp/shrc` @ codeberg.org](https://codeberg.org/djsp/shrc)
- [GNU Privacy Guard][] (GnuPG): [`kalrish/GnuPG-conf` @ github.com](https://github.com/kalrish/GnuPG-conf)
- [OpenSSH][]: [`djsp/ssh_config` @ codeberg.org](https://codeberg.org/djsp/ssh_config)


[cmd.exe]: https://en.wikipedia.org/wiki/Cmd.exe
[command-line shell]: https://wiki.archlinux.org/title/Command-line_shell
[GNU Privacy Guard]: https://www.gnupg.org/
[OpenSSH]: https://www.openssh.com/
[POSIX shell]: https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html
[XDG Base Directory Specification]: https://specifications.freedesktop.org/basedir-spec/latest/
