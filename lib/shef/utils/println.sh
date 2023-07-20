# shef__utils__println_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/die.sh

shef__fn_alias println

shef__println() {
	printf '%s\n' "$1" || shef__die 'print with printf'
}
