# shef__utils__read_into_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/die.sh

shef__fn_alias read_into

shef__read_into() {
	eval "$1=\$(cat)" || shef__die 'read with cat'
}
