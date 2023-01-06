# Miscellaneous helpers.
#
# Dependency:
#.  shef/fn-alias

shef__function_aliases \
	stdin_arg \
	die \
	quote \
	eval_assign \
	eval_quote_assign \
	read_all \
	print \
	print_line \
	check

# Newline character.
SHEF_NL='
'

##
# Pass argument to STDIN of specified command.
#
# Arguments:
#   $1 Argument to be passed to STDIN of command.
#   $@ Command with its own arguments.
#
# Outputs:
#   STDERR|STDOUT Same as the command outputs.
#
# Dies if:
#   - command dies (thus doesn't die for extranal program).
##
shef__stdin_arg() {
	shef__stdin_arg__arg="$1" && shift
	"$@" <<- EOF
		${shef__stdin_arg__arg}
	EOF
}

##
# Exit shell or subshell with code 1 and print optional error message.
#
# Arguments:
#   $1 Optional reason. The reason will be prefixed with 'cannot ' string.
#
# Outputs:
#   STDERR Optional error message with runner name and '!!! ' prefix.
#
# Dies:
#   - always.
##
shef__die() {
	if [ $# -gt 0 ]; then
		echo "${SHEF_RUNNER:+${SHEF_RUNNER}: }!!! cannot $1" 1>&2 || exit 1
	fi

	exit 1
}

##
# Put a string in a shell-quoted form.
#
# Arguments:
#   $1 String to be quoted.
#
# Outputs:
#   STDOUT Quoted string.
#
# Dies:
#   - never.
##
shef__quote() {
	stdin_arg "$1" sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/'/" \
		|| shef__die "quote string: '$1'"
}

shef__eval_assign() {
	eval "$1=$2" || shef__die "eval assign: $1=$2"
}

shef__eval_quote_assign() {
	shef__eval_quote_assign__quoted_value="$(shef__quote "$2")" || shef__die
	shef__eval_assign "$1" "${shef__eval_quote_assign__quoted_value}"
}

shef__read_all() {
	eval "$1=\$(cat)" || shef__die 'read with cat'
}

shef__print() {
	printf '%s' "$1" || shef__die 'print with printf'
}

shef__print_line() {
	printf '%s\n' "$1" || shef__die 'print with printf'
}

shef__check() {
	case "$1" in
		yes|Yes|YES|y|true|True|TRUE|t|1|on|On|ON|enable|Enable|ENABLE|enabled|Enabled|ENABLED) return 0;
		no|No|NO|n|false|False|FALSE|f|0|off|Off|OFF|disable|Disable|DISABLE|disabled|Disabled|DISABLED|'') return 1;
		*) shef__die "parse as boolean: '$1'"
	esac
}
