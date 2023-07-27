# shef__systemd___impl__make_service_state_name__sh
#
# Dependencies:
#.	shef/utils/die.sh
#.	shef/utils/arg.sh

# TODO: implement more robust way for service name transforming and sanitize its names
shef_impl__make_service_state_name() {
	shef_impl__make_service_state_name__result="$(arg "${1}_needs_${2}" tr - _)" \
		|| die "make service name with 'tr' utility"
}
