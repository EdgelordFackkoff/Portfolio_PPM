class_name walk_state

extends State_Player

@export var walk_speed = 5.0

func update(delta):
	#Detect if on ground
	if Global.player.is_on_floor():
		#Detect if idle
		if Global.player.velocity.x == 0 and Global.player.velocity.z == 0:
			#To idle
			transition.emit("idle_state")
			#Break
			return
		
		#Detect sprint
		if Input.is_action_pressed("sprint") && Global.player.is_sprint_allowed() == true:
			#You are now sprinting
			transition.emit("sprint_state")
			#Break
			return
		
		#Detect if Jumping
		if Input.is_action_just_pressed("jump"):
			Global.player.update_player_jump_last_speed(Global.player.get_speed())
			Global.player.update_player_before_jump_state("walk_state")
			transition.emit("jump_state")
			#Break
			return
	else:
		#To air state
		transition.emit("air_state")

func enter():
	Global.player.set_max_speed(walk_speed)

#get name
func getname():
	return ("walk_state")
