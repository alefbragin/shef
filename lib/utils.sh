# Miscellaneous helper functions

##
# Pass argument to STDIN of specified command
#
# Arguments:
#   $1 Argument to be passed to STDIN of command
#   $@ Command with its own arguments
#
# Outputs:
#   Same as the command outputs
#
# Dies if:
#   - command dies (thus doesn't die for extranal program)
##
stdin_arg() {
	arg="$1" && shift
	"$@" <<- EOF
		${arg}
	EOF
}

##
# Exit shell or subshell with code 1 and print optional error message
#
# Arguments:
#   $1 Optional error message
#
# Outputs:
#   STDERR Optional error message with '!!! ' prefix
#
# Dies:
#   - always
##
die() {
	if [ $# -gt 0 ]; then
		format="$1" && shift
		printf "!!! ${format}\n" "$@" 1>&2 || exit 1
	fi

	exit 1
}
