# Copyright 2021 University of Bonn
#
# SPDX-License-Identifier: GPL-3.0-or-later

## Specific environment variables helpful for Belle II.

# Squid servers for conditions database queries.
export BELLE2_CONDB_PROXY="http://squid.physik.uni-bonn.de:3128"

if [ -e /cvmfs/belle.cern.ch/tools/b2presetup.sh ]; then
	# Sourced only in a sub-shell. If things go awry or Belle II breaks something, we just ignore all this.
	BELLE2_SW_DIR=$(bash -c 'BELLE2_TOOLS=/cvmfs/belle.cern.ch/tools; . /cvmfs/belle.cern.ch/tools/b2presetup.sh; echo ${VO_BELLE2_SW_DIR}' 2>/dev/null)
	if [ -n "${BELLE2_SW_DIR}" -a -d "${BELLE2_SW_DIR}" ]; then
		# At this point, we know we are on an OS supported by Belle II software / externals.
		# Set up JUPYTER_PATH to expose Jupyter kernels for automatic loading.
		if [ -d "/cvmfs/belle.cern.ch" ] && [[ ":$JUPYTER_PATH:" != *":/cvmfs/belle.cern.ch:"* ]]; then
			# Append only if not present yet, see https://superuser.com/a/39995/858025 .
			JUPYTER_PATH="${JUPYTER_PATH:+"$JUPYTER_PATH:"}/cvmfs/belle.cern.ch"
			# Ensure it is exported.
			export JUPYTER_PATH
		fi
	fi
fi
