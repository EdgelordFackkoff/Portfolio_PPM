class_name Jump_State

extends State_Player

var base_jump_velocity = 2.5
var jump_multiplier = 0.75

#initial enter
func enter():
	#Debug
	print("jump state entered")
	
	#Get player speed
	var speed = Global.player.player_get_last_jump_speed()
	var direction_x = Global.player.player_get_direction_x()
	var direction_z = Global.player.player_get_direction_z()
	
	#Set player speed
	Global.player.set_max_speed(speed)
	
	Global.player.velocity.y = lerp(Global.player.velocity.y, base_jump_velocity + (speed * jump_multiplier), 1.00)

#Update
func update(delta):
	#Go into air state immediately
	transition.emit("air_state")

#get name
func getname():
	return ("jump_state")
