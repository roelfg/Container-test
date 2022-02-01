# Copyright 2017-2020 University of Bonn
#
# SPDX-License-Identifier: GPL-3.0-or-later

setupATLAS() {
  if ls /cvmfs/atlas.cern.ch > /dev/null 2>&1; then
    echo "Setting up CVMFS environment..."
    shopt -s expand_aliases
    export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
    export SITE_NAME=UNI-BONN
    source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh $*
    return $?
  else
    echo
    echo " ERROR: CVMFS not available on this host"
    echo
    return 1
  fi
}
