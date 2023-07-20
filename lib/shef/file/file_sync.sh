# shef__file__file_sync_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/die.sh
#.  shef/utils/indirect_assign.sh
#.  shef/utils/println.sh
#.  ./file_ensure_path.sh

shef__fn_alias file_sync

shef__file_sync() {
	shef__indirect_assign shef__file_sync__content "$1"
	shef__indirect_assign shef__file_sync__file "${1}_file"

	shef__file_ensure_path "${shef__file_sync__file}"
	shef__println "${shef__file_sync__content}" > "${shef__file_sync__file}" \
		|| shef__die "sync file: '${shef__file_sync__file}'"
}
