# Checking features enabling.
#
# Dependencies:
#.  shef/fn-alias
#.  shef/utils

shef__function_aliases \
	feature_enabled

shef__feature_enabled() {
	shef__feature_enabled__varname="$(
		shef__stdin_arg "SHEF_FEATURE_${1}" tr '[:lower:]' '[:upper:]'
	)" || shef__die "convert feature name to uppercase: '$1'"

	shef__indirect_assign shef__feature_enabled__enabled "${shef__feature_enabled__varname}"
	shef__check "${shef__feature_enabled__enabled}"
}
