# Contains functions for printing informational messages

##
# Print fancy section caption to STDOUT
# Arguments:
#   $1 Caption text
# Outputs:
#   STDOUT The passed text that decorated accordingly
##
info_section() {
  mainline="# $1 #"
  border="$(echo "${mainline}" | tr '[:print:]' '#')"
  printf '\n\n'
  printf '    %s\n' "${border}" "${mainline}" "${border}"
  printf '\n'
}

##
# Print info that the changes have occurred
# Arguments:
#   $1 Text to be printed
# Outputs:
#   STDOUT The passed text that decorated accordingly
##
info_changed() {
  echo "+++ $1"
}

##
# Print info that the required state has already been achived
# Arguments:
#   $1 Text to be printed
# Outputs:
#   STDOUT The passed text that decorated accordingly
##
info_already() {
  echo "=== $1"
}

##
# Print info that the changes are skipped because they are turned off manually
# Arguments:
#   $1 Text to be printed
# Outputs:
#   STDOUT The passed text that decorated accordingly
##
info_skipped() {
  echo "~~~ $1"
}

##
# Print info without any special meaning
# Arguments:
#   $1 Text to be printed
# Outputs:
#   STDOUT The passed text that decorated accordingly
##
info() {
  echo "### $1"
}
