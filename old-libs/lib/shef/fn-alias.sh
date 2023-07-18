# Maker of aliases of Shef's library functions without 'shef__' prefix.

##
# Make aliases of Shef's library functions without 'shef__' prefix.
#
# Arguments:
#   $1 Name of the alias.
#
# Globals:
#   $shef__$* Aliased function.
#   $* Function that is alias.
#
# Dies:
#   - never.
##
shef__function_aliases() {
	for shef__function_aliases__alias; do
		eval "${shef__function_aliases__alias}(){ shef__${shef__function_aliases__alias} \"\$@\";}"
	done
}
