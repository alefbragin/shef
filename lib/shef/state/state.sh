# shef__state__state_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/indirect_assign.sh
#.  shef/utils/die.sh
#.  shef/utils/read_into.sh
#.  shef/utils/print.sh
#.  shef/utils/assign.sh
#.  ./state_file.sh

shef__fn_alias state

# Print or test state.
#
# If only one argument was passed, print state to STDOUT.
# Otherwise test state for equality with second argument.
#
# Arguments:
#   $1 State name. The name must be match `[a-z0-9_]+`.
#   $2 State value to test for equality with actual state.
#
# Globals:
#   $shef__states__${1} State.
#
# Outputs:
#   STDOUT Print state value if only one argument was passed.
#
# Files:
#   in/out $(shef__state_file $1) File where state is stored.
#
# Dies if:
#   - cannot read state file.
shef__state() {
	shef__indirect_assign shef__state__value "shef__states__${1}"
	if [ -z "${shef__state__value}" ]; then
		shef__state__file="$(shef__state_file "$1")" || shef__die
		if [ -f "${shef__state__file}" ]; then
			shef__read_into "shef__states__${1}" < "${shef__state__file}" \
				|| shef__die "read state value from file: '${shef__state__file}'"
		fi
	fi

	if [ $# -gt 1 ]; then
		[ "${shef__state__value}" = "$2" ]
	else
		shef__print "${shef__state__value}"
	fi
}
