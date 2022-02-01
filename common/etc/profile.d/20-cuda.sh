# Copyright 2020 University of Bonn
#
# SPDX-License-Identifier: GPL-3.0-or-later

## Setup of CUDA stuff.

if [ -z "${CUDA_HOME}" ]; then
	if [ -e /usr/local/cuda ]; then
		export CUDA_HOME=/usr/local/cuda
		export PATH="${CUDA_HOME}/bin:${PATH}"
		if [ -e ${CUDA_HOME}/lib64 ]; then
			export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"
		fi
		if [ -e ${CUDA_HOME}/lib ]; then
			export LD_LIBRARY_PATH="${CUDA_HOME}/lib:${LD_LIBRARY_PATH}"
		fi
	fi
fi
