# shef__file__file_changed_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/indirect_assign.sh
#.  shef/utils/arg.sh

shef__fn_alias file_changed

shef__file_changed() {
	shef__indirect_assign shef__file_changed__content "$1"
	shef__indirect_assign shef__file_changed__file "${1}_file"

	if [ ! -f "${shef__file_changed__file}" ]; then
		return 0
	fi

	! shef__arg "${shef__file_changed__content}" \
		diff --brief "${shef__file_changed__file}" - > /dev/null
}
