# shef__utils__die_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh

shef__fn_alias die

# Exit shell or subshell with code 1 and print optional error message.
#
# Arguments:
#   $1 Optional reason. The reason will be prefixed with 'cannot ' string.
#
# Outputs:
#   STDERR Optional error message with runner name and '!!! ' prefix.
#
# Dies:
#   - always.
shef__die() {
	if [ $# -gt 0 ]; then
		echo "${SHEF_RUNNER:+${SHEF_RUNNER}: }!!! cannot $1" 1>&2 || exit 1
	fi

	exit 1
}
