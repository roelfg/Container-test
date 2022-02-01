# Copyright 2020 University of Bonn
#
# SPDX-License-Identifier: GPL-3.0-or-later

if [ -n "${_CONDOR_REMOTE_SPOOL_DIR}" ]; then
	# We are inside an MPI job!
	if [ -e /cvmfs/software.physik.uni-bonn.de/mpi/ ]; then
		# Protection against multiple set up.
		if [ "x${CONDOR_MPI_SETUP_DONE}" = "x" ]; then
			export CONDOR_MPI_SETUP_DONE=1
			export PATH=/cvmfs/software.physik.uni-bonn.de/mpi/:${PATH}

			# Networking setup: Use InfiniBand subnet.
			export OPENMPI_EXCLUDE_NETWORK_INTERFACES="docker0,virbr0"
			export OMPI_MCA_btl_tcp_if_include="10.161.8.0/23"
			export OMPI_MCA_oob_tcp_if_include="10.161.8.0/23"

			# MPDIR is different per distribution.
			case "${CONTAINER_OS_OS}" in
				Debian*) OPENMPI_INSTALL_PATH=/usr ;;
				Ubuntu*) OPENMPI_INSTALL_PATH=/usr ;;
				CentOS*) OPENMPI_INSTALL_PATH=/usr/lib64/openmpi ;;
				SL6)     OPENMPI_INSTALL_PATH=/usr/lib64/openmpi-1.10 ;;
				*)       OPENMPI_INSTALL_PATH=/usr ;;
			esac
			export OPENMPI_INSTALL_PATH
		fi
	fi
fi
