#!/bin/bash -l

# Copyright 2020 Karlsruhe Institute of Technology KIT
#
# SPDX-License-Identifier: GPL-3.0-or-later

# Wrapper when executing condor jobs
# Run jobs via `bash -l` to force sourcing a login shell including all /etc/profile.d/*.sh scripts
#
exec "$@"
