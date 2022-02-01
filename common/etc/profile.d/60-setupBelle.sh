# Copyright 2017-2020 University of Bonn
#
# SPDX-License-Identifier: GPL-3.0-or-later

setupBelle() {
  if ls /cvmfs/belle.cern.ch > /dev/null 2>&1; then
    echo "Setting up CVMFS environment..."
    shopt -s expand_aliases
    source /cvmfs/belle.cern.ch/tools/b2setup
    return $?
  else
    echo
    echo " ERROR: CVMFS not available on this host"
    echo
    return 1
  fi
}
