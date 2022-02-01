# Copyright 2018-2020 University of Bonn
#
# SPDX-License-Identifier: GPL-3.0-or-later

## Helpful environment definitions for users.

# Define USER, not defined in non-interactive jobs otherwise.
export USER=$(/usr/bin/whoami)

# BUDDY: BAF User Data DirectorY.
if [ -d /cephfs/user/${USER} ]; then
	export BUDDY=/cephfs/user/${USER}
fi

# BADDY: BAcked-up Data DirectorY.
if [ -d /cephfs/backup/${USER} ]; then
	export BADDY=/cephfs/backup/${USER}
fi

# ContainerOS, and split into OS and TYPE part.
export CONTAINER_OS=$(cat /etc/ContainerOS)
export CONTAINER_OS_OS=${CONTAINER_OS%_*}
export CONTAINER_OS_TYPE=${CONTAINER_OS#*_}

# Short version of ContainerOS, to be used e.g. for prompt.
if [ "x${CONTAINER_OS_TYPE}" = "xdefault" ]; then
	export CONTAINER_OS_SHORT=${CONTAINER_OS_OS}
else
	export CONTAINER_OS_SHORT=${CONTAINER_OS}
fi
