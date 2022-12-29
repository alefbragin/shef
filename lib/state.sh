# Reading/writing Shef state.
#
# Dependencies:
#.  shef/defaults/storage-path
#.  shef/utils
#.  shef/file

state_file() {
	file_name="$(stdin_arg "$1" tr _ -)" \
		|| die "make state file name from: '$1'"
	print_line "${SHEF_STORAGE_PATH}/state/${file_name}"
}

##
# Set arbitary string as a state: assign it to appropriate variable and write to appropriate file.
#
# Arguments:
#   $1 State name. The name must be match `[a-z0-9_]+`.
#
# Globals:
#   $shef_state_* State.
#   $shef_state_*_file Path of a file where state will be stored.
#
# Files:
#   $shef_state_*_file (in/out) File where state is stored.
#
# Dies if:
#   - cannot read or write state file.
##
state_set() {
	var_name="shef_state_${1}"
	eval_quote_assign "${var_name}" "$2"

	file_var_name="shef_state_${1}_file"
	file="$(state_file "$1")" || die
	eval_quote_assign "${file_var_name}" "${file}"

	if file_changed "${var_name}"; then
		file_sync "${var_name}"
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
#   $shef_state_* State.
#
# Outputs:
#   STDOUT Print state value if only one argument was passed.
#
# Files:
#   $shef_state_*_file (in/out) File where state is stored.
#
# Dies if:
#   - cannot read state file.
##
state() {
	var_name="shef_state_${1}"

	eval_quote value "\${${var_name}}"
	if [ -z "${value}" ]; then
		file="$(state_file "$1")" || die
		if [ -f "${file}" ]; then
			read_all "${value}" < "${file}" \
				|| die "read state value from file: '${file}'"

			eval_quote_assign "${var_name}" "${value}"
		fi
	fi

	if [ $# -gt 1 ]; then
		[ "${value}" = "$2" ]
	else
		print "${value}"
	fi
}
