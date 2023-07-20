# shef__file__file_set_sh
#
# Dependencies:
#.  shef/utils/assign.sh

shef__fn_alias file_set

shef__file_set() {
	shef__assign "${1}_file" "$2"
}
