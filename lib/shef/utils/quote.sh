# shef__utils__quote_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/die.sh
#.  shef/utils/arg.sh

shef__fn_alias quote

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
shef__quote() {
	shef__arg "$1" sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/'/" \
		|| shef__die "quote string: '$1'"
}
