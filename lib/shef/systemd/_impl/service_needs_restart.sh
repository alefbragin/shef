# shef__systemd___impl__service_needs_restart__sh
#
# Dependencies:
#.	shef/state/state_set.sh
#.	./make_service_state_name.sh

shef__service_needs_restart() {
	shef_impl__make_service_state_name "$1" restart
	shef__state_set "$shef_impl__make_service_state_name__result" 1
}
