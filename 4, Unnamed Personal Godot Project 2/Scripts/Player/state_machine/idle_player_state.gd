class_name Idle_state

extends State_Player

func enter():
	#Walkaround
	if Global.player:
		Global.player.set_current_speed(0.0)
		Global.player.set_max_speed(3.0)

func update(delta):
	
	#Detect if on floor
	if Global.player.is_on_floor():
		#To walk or Spring
		if Global.player.velocity.x != 0 or Global.player.velocity.z != 0:
			#Detect sprint
			if Input.is_action_pressed("sprint") && Global.player.is_sprint_allowed() == true:
				#You are now sprinting
				transition.emit("sprint_state")
				#break
				return
			else:
				#You are now walking
				transition.emit("walk_state")
				#break
				return
		
		#Detect if Jumping
		if Input.is_action_just_pressed("jump"):
			Global.player.update_player_jump_last_speed(Global.player.get_speed())
			Global.player.update_player_before_jump_state("idle_state")
			transition.emit("jump_state")
			#Break
			return

	else:
		#To air state
		transition.emit("air_state")
		#break
		return

#get name
func getname():
	return ("idle_state")
