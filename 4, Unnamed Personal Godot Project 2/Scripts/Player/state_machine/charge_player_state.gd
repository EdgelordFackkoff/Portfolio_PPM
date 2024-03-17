class_name Charge_State

extends State_Player

@export var sprint_speed = 15.0

#initial enter
func enter():
	Global.player.set_max_speed(sprint_speed)

func update(delta):

	#Detect if on ground
	if Global.player.is_on_floor():
		#Detect if no longer sprinting
		if Input.is_action_just_released("sprint"):
			#You are now wealking
			transition.emit("walk_state")
			#Break
			return
		
		#Detect if Jumping
		if Input.is_action_just_pressed("jump"):
			Global.player.update_player_jump_last_speed(Global.player.get_speed())
			Global.player.update_player_before_jump_state("charge_state")
			transition.emit("jump_state")
			#Break
			return
		
		#Detect if Idle
		if Global.player.velocity.x == 0 and Global.player.velocity.z == 0:
			#You are now idling
			transition.emit("idle_state")
			#Break
			return
			
		#Detect if you can still sprint
		if Global.player.is_sprint_allowed() == false:
			#Check idle or walk
			if Global.player.velocity.x != 0 and Global.player.velocity.z != 0:
				#To Walk
				transition.emit("walk_state")
				#Break
				return
			else:
				#To idle
				transition.emit("idle_state")
				#Break
				return
		
	else:
		#Air State
		transition.emit("air_state")
		#Break
		return

#get name
func getname():
	return ("charge_state")
