# shef__utils__arg_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh

shef__fn_alias arg

# Pass argument to STDIN of specified command. In a sense, it is a reverse of xarg.
#
# Arguments:
#   $1 Argument to be passed to STDIN of command.
#   $@ Command with its own arguments.
#
# Outputs:
#   STDERR|STDOUT Same as the command outputs.
#
# Dies if:
#   - command dies (thus doesn't die for external program).
shef__arg() {
	shef__stdin_arg__arg="$1" && shift
	"$@" <<- EOF
		${shef__stdin_arg__arg}
	EOF
}
