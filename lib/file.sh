# File utilities.
#
# Dependencies:
#.  shef/fn-alias
#.  shef/utils

shef__function_aliases \
	file_ensure_path \
	file_set \
	file_sync \
	file_changed

shef__file_ensure_path() {
	shef__file_ensure_path__dir="$(dirname "$1")" \
		|| shef__die "extract directory name from the path: '$1'"
	mkdir --parents "${shef__file_ensure_path__dir}" \
		|| shef__die "create directory: '${shef__file_ensure_path__dir}'"
}

shef__file_set() {
	shef__eval_quote_assign "${1}_file" "$2"
}

shef__file_sync() {
	shef__assign_eval shef__file_sync__content "\${$1}"
	shef__assign_eval shef__file_sync__file "\${${1}_file}"

	shef__file_ensure_path "${shef__file_sync__file}"
	shef__print_line "${shef__file_sync__content}" > "${shef__file_sync__file}" \
		|| shef__die "sync file: '${shef__file_sync__file}'"
}

shef__file_changed() {
	shef__assign_eval shef__file_changed__content "\${$1}"
	shef__assign_eval shef__file_changed__file "\${${1}_file}"

	if [ ! -f "${shef__file_changed__file}" ]; then
		return 0
	fi

	! shef__stdin_arg "${shef__file_changed__content}" \
		diff --brief "${shef__file_changed__file}" - > /dev/null
}
