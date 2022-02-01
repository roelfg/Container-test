# Copyright 2019-2021 University of Bonn
#
# SPDX-License-Identifier: GPL-3.0-or-later

if [ -r "${_CONDOR_JOB_AD}" ]; then
	REQUEST_CPUS=$(awk '/^RequestCpus/{print $3}' ${_CONDOR_JOB_AD})
	REQUEST_MEMORY=$(awk '/^RequestMemory/{print $3}' ${_CONDOR_JOB_AD})
	REQUEST_DISK=$(awk '/^RequestDisk/{print $3}' ${_CONDOR_JOB_AD})
	# Protection against multiply echoing resource request.
	if [ "x${ECHOED_RESOURCE_REQUEST}" = "x" ]; then
		# Only if shell is interactive, a login shell, and TERM is defined.
		[[ $- == *i* ]] && shopt -q login_shell && [ -n "$TERM" ] && export ECHOED_RESOURCE_REQUEST=1 && echo "You requested ${REQUEST_CPUS} core(s), ${REQUEST_MEMORY} MB RAM, ${REQUEST_DISK} kB disk space."
	fi
else
	# Should never enter here...
	REQUEST_CPUS=1
	REQUEST_MEMORY=1024
fi

# Used by JupyterHub resource usage extension.
export CPU_LIMIT=$(( ${REQUEST_CPUS} * 100 ))
export MEM_LIMIT=$(( ${REQUEST_MEMORY} * 1024 * 1024 ))

export NUMEXPR_NUM_THREADS=${REQUEST_CPUS}
export MKL_NUM_THREADS=${REQUEST_CPUS}
export OMP_NUM_THREADS=${REQUEST_CPUS}
export CUBACORES=${REQUEST_CPUS}
export JULIA_NUM_THREADS=${REQUEST_CPUS}
export OPENBLAS_NUM_THREADS=${REQUEST_CPUS}
# Tensorflow related variables,
# see https://github.com/theislab/diffxpy/blob/master/docs/parallelization.rst
export TF_NUM_THREADS=${REQUEST_CPUS}
export TF_LOOP_PARALLEL_ITERATIONS=${REQUEST_CPUS}
