# Miscellaneous helpers.

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
stdin_arg() {
	arg="$1" && shift
	"$@" <<- EOF
		${arg}
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
die() {
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
quote() {
	stdin_arg "$1" sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/'/" \
		|| die "quote string: '$1'"
}

eval_assign() {
	eval "$1=$2" || die "eval assign: '$1' <- '$2'"
}

eval_quote_assign() {
	quoted_value="$(quote "$2")" || die
	eval_assign "$1" "${quoted_value}"
}

read_all() {
	eval "$1=\$(cat)" || die 'read with cat'
}

print() {
	printf '%s' "$1" || die 'print with printf'
}

print_line() {
	printf '%s\n' "$1" || die 'print with printf'
}
