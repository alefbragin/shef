# shef__utils__assign_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/die.sh
#.  shef/utils/quote.sh

shef__fn_alias assign

shef__assign() {
	shef__assign__quoted="$(shef__quote "$2")" || shef__die
	eval "$1=${shef__assign__quoted}" || shef__die "assign: $1=$2"
}
