# shef__file__file_ensure_path_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/die.sh

shef__fn_alias file_ensure_path

shef__file_ensure_path() {
	shef__file_ensure_path__dir="$(dirname "$1")" \
		|| shef__die "extract directory name from the path: '$1'"
	mkdir --parents "${shef__file_ensure_path__dir}" \
		|| shef__die "create directory: '${shef__file_ensure_path__dir}'"
}
