# Miscellaneous helpers.

# Newline character.
SHEF_NL='
'

##
# Make alias of Shef's library function without 'shef__' prefix.
#
# Arguments:
#   $1 Name of the alias.
#
# Globals:
#   $shef__$1 Aliased function.
#   $1 Function that is alias.
#
# Dies:
#   - never.
##
shef__fn_alias() {
	eval "$1(){ shef__$1 \"\$@\";}"
}

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
shef__fn_alias stdin_arg

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
shef__fn_alias die

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
shef__fn_alias quote

shef__eval_assign() {
	eval "$1=$2" || shef__die "eval assign: $1=$2"
}
shef__fn_alias eval_assign

shef__eval_quote_assign() {
	shef__eval_quote_assign__quoted_value="$(shef__quote "$2")" || shef__die
	shef__eval_assign "$1" "${shef__eval_quote_assign__quoted_value}"
}
shef__fn_alias eval_quote_assign

shef__read_all() {
	eval "$1=\$(cat)" || shef__die 'read with cat'
}
shef__fn_alias read_all

shef__print() {
	printf '%s' "$1" || shef__die 'print with printf'
}
shef__fn_alias print

shef__print_line() {
	printf '%s\n' "$1" || shef__die 'print with printf'
}
shef__fn_alias print_line
