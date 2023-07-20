# shef__state__state_check_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/die.sh
#.  shef/utils/check.sh
#.  ./state.sh

shef__fn_alias state_check

shef__state_check() {
	shef__state_check__state="$(shef__state "$1")" || shef__die
	shef__check "${shef__state_check__state}"
}
