# Copyright 2018-2021 University of Bonn
#
# SPDX-License-Identifier: GPL-3.0-or-later

## Condor-Job specific environment variables.

# Ensure TMPDIR in subdirectory of _CONDOR_SCRATCH_DIR which usually is /jwd, not in /tmp which is in OverlayFS (memory).
# Subdirectory ensures we do not do file transfer of TMP stuff back to the submit host.
# This also does the correct thing for an overlay batch system using HTCondor since _CONDOR_SCRATCH_DIR will be set,
# and will leave things alone in case HTCondor is not seen.
# Special case: If /jwd is identical to the scratch dir, prefer that. This ensures software compiled there
#               will not hardcode a different, potentially job-dependent path.
if [ -n "${_CONDOR_SCRATCH_DIR}" -a -e "${_CONDOR_SCRATCH_DIR}" ]; then
	SCRATCH_DIR="${_CONDOR_SCRATCH_DIR}"
	# Check if /jwd exists and is identical to _CONDOR_SCRATCH_DIR.
	if [ -e /jwd ]; then
		DEV_INODE_JWD=$(stat -c "%d.%i" /jwd 2>/dev/null)
		RES_1=$?
		DEV_INODE_SCRATCH=$(stat -c "%d.%i" "${_CONDOR_SCRATCH_DIR}" 2>/dev/null)
		RES_2=$?
		if [ $RES_1 -eq 0 -a $RES_2 -eq 0 -a "${DEV_INODE_JWD}" = "${DEV_INODE_SCRATCH}" ]; then
			SCRATCH_DIR=/jwd
		fi
	fi
	mkdir -p "${SCRATCH_DIR}/tmp"
	export TMPDIR="${SCRATCH_DIR}/tmp"
fi

# If TMPDIR is not set, ensure it is set to /tmp.
if [ -z "${TMPDIR}" ]; then
	export TMPDIR=/tmp
fi

# If TMPDIR does not exist, try to create it.
# If that fails, it may be inherited, e.g. from outside the container.
# Then, use /jwd/tmp if /jwd exists, otherwise use /tmp.
if [ ! -e "${TMPDIR}" ]; then
	mkdir -p "${TMPDIR}" 2> /dev/null
	if [ $? -ne 0 ]; then
		if [ -e /jwd ]; then
			mkdir -p /jwd/tmp
			export TMPDIR=/jwd/tmp
		else
			export TMPDIR=/tmp
		fi
	fi
fi

# Ensure TEMP and TMP are set to the same directory.
export TEMP="${TMPDIR}"
export TMP="${TMPDIR}"
