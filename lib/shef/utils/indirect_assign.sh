# shef__utils__indirect_assign_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/die.sh

shef__fn_alias indirect_assign

shef__indirect_assign() {
	eval "$1=\${$2}" || shef__die "indirect assign: $1=\${$2}"
}
