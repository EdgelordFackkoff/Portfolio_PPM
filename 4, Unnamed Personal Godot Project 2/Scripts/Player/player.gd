class_name Entity_Player

extends Entity

#others
var sprint_allowed
var last_speed
var player_before_jump_state = "idle_state"

#mouse
var mouse_sens = Global.mouse_sens
var mouse_input: Vector2

#Reference Nodes
@export var camera_node: Node3D
@export var player_camera: Camera3D
@export var fps_rig: Node3D
@export var timers = Node
@export var player_character_area: Area3D
@export var state_machine: Node
@export var rig_node: Node3D

#Camera Variables
@export var deg_to_rad_camera_limit_1 = -40
@export var deg_to_rad_camera_limit_2 = 80
@export var weapon_cam_tilt = 0.1
@export var weapon_sway_rotation = 0.01
const var_view_slow_factor = 0.25
var bob_amount = 0.05
var bob_freq = 0.01

#Default positions
var default_rig_node_position: Vector3
var default_fps_rig_position: Vector3

#States
var charging = false
var ischarged = false
var player_can_move = true

#Ready
func _ready():
	#Reference Self for Global Fuckery
	Global.player = self
	
	#Set variables
	#movement variables
	current_speed = 5.0
	#3.0 for default running
	acceleration = 0.05
	decceleration = 0.25
	max_speed = 0.0
	
	#Defauly positions
	default_rig_node_position = rig_node.position
	default_rig_node_position = fps_rig.position

#Handles any input sheningans
func _unhandled_input(event):
	#Detects if input is indeed mouse sheningans
	if event is InputEventMouseMotion:
		#Rotate the "head" on y
		camera_node.rotate_y(-event.relative.x * mouse_sens * var_view_slow_factor)
		#Rotate camera on x
		player_camera.rotate_x(-event.relative.y * mouse_sens * var_view_slow_factor)
		#Clamps Camera
		player_camera.rotation.x = clamp(player_camera.rotation.x, deg_to_rad(deg_to_rad_camera_limit_1), deg_to_rad(deg_to_rad_camera_limit_2))
		mouse_input = event.relative

#Update functions
#Update the current Speed
func update_player_current_speed(delta):
	if current_state != "idle_state":
		current_speed = lerp(current_speed, max_speed, delta * 2.0)
	else:
		current_speed = 0.0
	if current_speed != last_speed:
		#Update debug
		var display_speed = "%.2f" % current_speed
		Global.debug_panel.add_property("Movement Speed", display_speed, 1)
		#debug
		last_speed = current_speed

#Update State Machine
func update_player_state_machine():
	#get current state from state machine
	current_state = state_machine.get_current_state().getname()
	if current_state != last_state:
		#Update State
		print(current_state)
		Global.debug_panel.add_property("Player State", current_state, 2)
		last_state = current_state

func update_player_jump_last_speed(last_jump_speed):
	last_speed = last_jump_speed

func update_player_before_jump_state(last_state_before_jump):
	player_before_jump_state = last_state_before_jump

#Get Functions
#detect if sprint allowed
func is_sprint_allowed():
	if sprint_allowed == true:
		return true
	elif sprint_allowed == false:
		return false

#detect if moving forward
func player_sprint_detection_check():
	
	#Check if on floor
	if is_on_floor():
		#Check if walled
		pass
	#No floor no sprint
	else:
		#Disallow sprint
		sprint_allowed = false

func player_get_direction_x():
	return direction_x

func player_get_direction_z():
	return direction_z

func player_get_last_jump_speed():
	return last_speed

func player_get_before_jump_state():
	return player_before_jump_state

func weapon_camera_tilt(input_x, delta):
	if rig_node:
		rig_node.rotation.z = lerp(rig_node.rotation.z, -input_x * weapon_cam_tilt, 10 * delta)

func weapon_rig_tilt(input_x, delta):
	if rig_node:
		rig_node.rotation.z = lerp(rig_node.rotation.z, -input_x * weapon_sway_rotation, 10 * delta)

func weapon_sway(input_x, delta):
	mouse_input = lerp(mouse_input, Vector2.ZERO, 10 * delta)
	rig_node.rotation.x = lerp(rig_node.rotation.x, mouse_input.y * weapon_sway_rotation, 10 * delta)
	rig_node.rotation.y = lerp(rig_node.rotation.y, mouse_input.x * weapon_sway_rotation, 10 * delta)

func weapon_bob(vel, delta):
	if rig_node:
		if (vel.x != 0.0 or vel.z != 0.0) and is_on_floor():
			rig_node.position.y = lerp(rig_node.position.y, default_rig_node_position.y + sin(Time.get_ticks_msec() * bob_freq) * bob_amount, 10 * delta)
			rig_node.position.x = lerp(rig_node.position.x, default_rig_node_position.x + sin(Time.get_ticks_msec() * bob_freq * 0.5) * bob_amount, 10 * delta)
		else:
			rig_node.position.y = lerp(rig_node.position.y, default_rig_node_position.y, 10 * delta)
			rig_node.position.x = lerp(rig_node.position.x, default_rig_node_position.x, 10 * delta)

func _physics_process(delta):

	#Update State Machine
	update_player_state_machine()

	#Update current speed
	update_player_current_speed(delta)
	
	#sprint detection check
	player_sprint_detection_check()

	#Detect if you can actually move
	if player_can_move == true:
		var input_dir = Input.get_vector("left", "right", "forward", "backward")
		var direction = (camera_node.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		direction_x = direction.x
		direction_z = direction.z
		if is_on_floor():
			if direction:
				#workaround
				if current_speed == 0.0:
					set_current_speed(1.0)
				#lerp for smooth experience
				velocity.x = lerp(velocity.x, direction.x * current_speed, acceleration)
				velocity.z = lerp(velocity.z, direction.z * current_speed, acceleration)
			else:
				#move towards for a quick stop
				velocity.x = move_toward(velocity.x, 0, decceleration)
				velocity.z = move_toward(velocity.z, 0, decceleration)
		#if in air
		else:
			velocity.x = lerp(velocity.x, direction.x * current_speed, 0.05)
			velocity.z = lerp(velocity.z, direction.z * current_speed, 0.05)
		
		#Weapon Tilts
		weapon_camera_tilt(input_dir.x, delta)
		weapon_rig_tilt(input_dir.x, delta)
		weapon_sway(input_dir.x, delta)
		weapon_bob(velocity, delta)
	
		
	#Something something ramps
	move_and_slide()

func _charge_effect():
	if charging == true:
		print("charged with velocity of ", current_speed)
		#Save current speed for later stuff aka Damage
		var charged_speed = current_speed
		#Reset speed
		current_speed = 0.0
		#cooldown
		ischarged = true
		charging = false
		player_can_move = false
		timers._timer_charge()
		timers._timer_unmoveable_charged()
		#Failsafe

func _resetcharge():
	ischarged = false
	#Fail Safe
	charging = false

func _allowmovement():
	player_can_move = true
