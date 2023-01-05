# File utilities.
#
# Dependencies:
#.  shef/utils

shef__file_ensure_path() {
	shef__file_ensure_path__dir="$(dirname "$1")" \
		|| shef__die "extract directory name from the path: '$1'"
	mkdir --parents "${shef__file_ensure_path__dir}" \
		|| shef__die "create directory: '${shef__file_ensure_path__dir}'"
}
shef__fn_alias file_ensure_path

shef__file_set() {
	shef__eval_quote_assign "${1}_file" "$2"
}
shef__fn_alias file_set

shef__file_sync() {
	shef__eval_assign shef__file_sync__content "\${$1}"
	shef__eval_assign shef__file_sync__file "\${${1}_file}"

	shef__file_ensure_path "${shef__file_sync__file}"
	shef__print_line "${shef__file_sync__content}" > "${shef__file_sync__file}" \
		|| shef__die "sync file: '${shef__file_sync__file}'"
}
shef__fn_alias file_sync

shef__file_changed() {
	shef__eval_assign shef__file_changed__content "\${$1}"
	shef__eval_assign shef__file_changed__file "\${${1}_file}"

	if [ ! -f "${shef__file_changed__file}" ]; then
		return 0
	fi

	! shef__stdin_arg "${shef__file_changed__content}" \
		diff --brief "${shef__file_changed__file}" - > /dev/null
}
shef__fn_alias file_changed
