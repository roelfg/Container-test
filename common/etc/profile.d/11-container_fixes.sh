# Copyright 2018-2021 University of Bonn
#
# SPDX-License-Identifier: GPL-3.0-or-later

# Helps with starting X11 applications, needed for CentOS 7, speedups on others.
export DBUS_SESSION_BUS_ADDRESS=unix:path=/tmp/dbus_session_addr

# Since /run is not writable but on CVMFS, adjust directory to use for screen sockets.
export SCREENDIR=$HOME/.screen

# Adjust cache paths to ensure temporary cache files do not end up in HOME (where they might be transferred back).
if [ -z "${XDG_CACHE_HOME}" ]; then
	export XDG_CACHE_HOME=${TMPDIR}/cache
	mkdir -p ${XDG_CACHE_HOME}
fi
if [ -z "${npm_config_cache}" ]; then
	export npm_config_cache=${TMPDIR}/npm-cache
fi

# Also set runtime directory to a temporary path.
if [ -z "${XDG_RUNTIME_DIR}" ]; then
	export XDG_RUNTIME_DIR=${TMPDIR}/run
	mkdir -p ${XDG_RUNTIME_DIR}
fi
