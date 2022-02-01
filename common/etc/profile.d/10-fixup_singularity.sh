# Copyright 2018-2021 University of Bonn
#
# SPDX-License-Identifier: GPL-3.0-or-later

# Dirty hack for issue: https://github.com/sylabs/singularity/issues/1419
if [ ! -e /dev/fd ]; then
	ln -s /proc/self/fd /dev/fd
	ln -s /proc/self/fd/0 /dev/stdin
	ln -s /proc/self/fd/1 /dev/stdout
	ln -s /proc/self/fd/2 /dev/stderr
fi

# Dirty hack for issue: https://github.com/sylabs/singularity/issues/3670
if [ ! -e /dev/tty -a -e /dev/pts/0 ]; then
	ln -s /dev/pts/0 /dev/tty
fi

# If environment was destroyed, e.g. by changing interpreter (to "script"), fixup things.
if [ -z "${HOME}" ]; then
	export HOME=${SINGULARITY_HOME}
	# Also do a TERM definition only here, only want to do that if we are in a known-broken environment.
	export TERM="linux"
fi

# If TERM is dumb, also "upgrade" that to "linux". Seems to happen when using unprivileged sshd + nsenter.
if [ "x${TERM}" = "xdumb" ]; then
	export TERM="linux"
fi

# If LD_LIBRARY_PATH does not contain the Singularity specific bind mount target, add that.
# Usually done in /.singularity.d/env/99-base.sh, but we might not have sourced that.
if [ -d "/.singularity.d/libs" ] && [[ ":$LD_LIBRARY_PATH:" != *":/.singularity.d/libs:"* ]]; then
	# Prepend only if not present yet, see https://superuser.com/a/39995/858025 .
	LD_LIBRARY_PATH="/.singularity.d/libs${LD_LIBRARY_PATH:+":$LD_LIBRARY_PATH"}"
fi

# Singularity sets "C" locale in "-C" (i.e. full containment) mode. We prefer something with utf8.
if [ -z "${LANG}" -o "x${LANG}" = "xC" ]; then
	export LANG=en_US.utf8
fi
