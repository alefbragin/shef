# Reading/writing Shef persistent state.
#
# Dependencies:
#.  shef/defaults/storage-path
#.  shef/fn-alias
#.  shef/utils
#.  shef/file

shef__function_aliases \
	state_set \
	state \
	state_check

shef__state_file() {
	shef__state_file__filename="$(shef__stdin_arg "$1" tr _ -)" \
		|| shef__die "make state file name from: '$1'"
	shef__print_line "${SHEF_STORAGE_PATH}/state/${shef__state_file__filename}"
}

##
# Set arbitary string as a state: assign it to appropriate variable and write to appropriate file.
#
# Arguments:
#   $1 State name. The name must be match `[a-z0-9_]+`.
#
# Globals:
#   $shef__states__${1} State.
#   $shef__states__${1}_file Path of a file where state will be stored.
#
# Files:
#   in/out $(shef__state_file $1) File where state is stored.
#
# Dies if:
#   - cannot read or write state file.
##
shef__state_set() {
	shef__eval_quote_assign "shef__states__${1}" "$2"

	shef__state_set__file="$(shef__state_file "$1")" || shef__die
	shef__file_set "shef__states__${1}" "${shef__state_set__file}"
	if shef__file_changed "shef__states__${1}"; then
		shef__file_sync "shef__states__${1}"
	fi
}

##
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
##
shef__state() {
	shef__assign_eval shef__state__value "\${shef__states__${1}}"
	if [ -z "${shef__state__value}" ]; then
		shef__state__file="$(shef__state_file "$1")" || shef__die
		if [ -f "${shef__state__file}" ]; then
			shef__read_all "${shef__state__value}" < "${shef__state__file}" \
				|| shef__die "read state value from file: '${shef__state__file}'"

			shef__eval_quote_assign "shef__states__${1}" "${shef__state__value}"
		fi
	fi

	if [ $# -gt 1 ]; then
		[ "${shef__state__value}" = "$2" ]
	else
		shef__print "${shef__state__value}"
	fi
}

shef__state_check() {
	shef__state_check__state="$(shef__state "$1")" || shef__die
	shef__check "${shef__state_check__state}"
}
