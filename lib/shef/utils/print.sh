# shef__utils__print_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/die.sh

shef__fn_alias print

shef__print() {
	printf '%s' "$1" || shef__die 'print with printf'
}
