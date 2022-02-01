# Copyright 2020 University of Bonn
#
# SPDX-License-Identifier: GPL-3.0-or-later

## Fixes and workarounds for HTcondor issues.

# This works in conjunction with our xauth_wrapper hack,
# which stores the DISPLAY variable in ".display" inside the job working directory.
if [ -r /jwd/.display ]; then
	source /jwd/.display
	rm -f /jwd/.display
fi
