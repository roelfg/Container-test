# Copyright 2019-2020 University of Bonn
#
# SPDX-License-Identifier: GPL-3.0-or-later

# Protection against multiply setting up prompt.
if [ "x${PROFILE_SETUP_CONTAINER_PROMPT}" = "x" ]; then
	# Only if shell is interactive, a login shell, and TERM is defined.
	# User can always override with custom container-specific bashrc.
	[[ $- == *i* ]] && shopt -q login_shell && [ -n "$TERM" ] && export PROFILE_SETUP_CONTAINER_PROMPT=1 && export PS1="\u@\h(${CONTAINER_OS_SHORT}) \w \$ "
fi

# Ensure Singularity's PROMPT_COMMAND does not enforce a "Singularity> " shell PS1, which is rather useless.
# They really force that since Greg Kurtzer himself preferred it this way:
# https://github.com/hpcng/singularity/issues/2721
unset PROMPT_COMMAND
