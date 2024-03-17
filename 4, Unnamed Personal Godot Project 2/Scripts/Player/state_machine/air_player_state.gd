class_name Air_State

extends State_Player

var airtime = 0.0

func update(delta):
	#Detect if on floor
	if Global.player.is_on_floor():
		#Reset Airtime
		airtime = 0.0
		#Transition
		Global.player.set_max_speed(0.0)
		transition.emit("idle_state")
		#Set player speed
		#Break
		return
	
	else:
		#Update Gravity pull
		Global.player.update_gravity(delta, airtime)
		#Slightly lower max_speed
		var new_max_speed = lerp(Global.player.get_max_speed(), Global.player.get_max_speed() - 1.00, 0.05)
		Global.player.set_max_speed(clamp(new_max_speed, 0.0, 15.0))
		#incease airtime
		airtime += 1.0

#get name
func getname():
	return ("air_state")
