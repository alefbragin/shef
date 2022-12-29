# File utilities.
#
# Dependencies:
#.  shef/utils

file_ensure_containing_directory() {
	dir="$(dirname "$1")" || die "extract directory name from the path: '$1'"
	mkdir --parents "${dir}" || die "create directory: '${dir}'"
}

file_sync() {
	eval_assign content "\${$1}"
	eval_assign file "\${${1}_file}"

	file_ensure_containing_directory "${file}"
	print_line "${content}" > "${file}" || die "sync file: '${file}'"
}

file_changed() {
	eval_assign content "\${$1}"
	eval_assign file "\${${1}_file}"

	if [ ! -f "${file}" ]; then
		return 0
	fi

	! stdin_arg "${content}" diff --brief "${file}" - > /dev/null
}
