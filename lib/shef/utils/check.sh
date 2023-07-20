# shef__utils__check
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/die.sh

shef__fn_alias check

shef__check() {
	case "$1" in
		yes|Yes|YES|y|true|True|TRUE|t|1|on|On|ON|enable|Enable|ENABLE|enabled|Enabled|ENABLED) return 0 ;;
		no|No|NO|n|false|False|FALSE|f|0|off|Off|OFF|disable|Disable|DISABLE|disabled|Disabled|DISABLED|'') return 1 ;;
		*) shef__die "parse as boolean: '$1'" ;;
	esac
}
