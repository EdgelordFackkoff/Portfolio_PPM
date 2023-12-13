extends Node3D

# camera_move
@export_range(0,100,1) var camera_move_speed:float = 8.0
@export_range(0,100,1) var camera_move_limit_x_left = -9
@export_range(0,100,1) var camera_move_limit_x_right = 10
@export_range(0,100,1) var camera_move_limit_z_up = -6
@export_range(0,100,1) var camera_move_limit_z_down = 7

# camera_pan
@export_range (0,32,4) var camera_automatic_pan_margin: int = 16
@export_range (0,20,0.5) var camera_automatic_pan_speed: float = 8

# camera_zoom
var camera_zoom_direction:float = 0
@export_range(0,100,1) var camera_zoom_speed = 4.0
@export_range(0,100,1) var camera_zoom_min = 2.0
@export_range(0,100,1) var camera_zoom_max = 10.00
@export_range(0,2,0.1) var camera_zoom_speed_damp:float = 0.5
var camera_zoom_current = 0.0

#Flags
var camera_can_process:bool = true
var camera_can_move_base:bool = true
var camera_can_zoom:bool = true
var camera_can_pan:bool = true


#Nodes
@onready var camera:Camera3D = $Camera3D

func _ready() -> void:
	pass
	

func _process(delta:float) -> void:
	#No Cameras for you
	if !camera_can_process:return
	
	camera_base_move(delta)
	camera_zoom_update(delta)
	camera_automatic_pan(delta)
	
	#Bandaid
	position.x = clamp(position.x, camera_move_limit_x_left, camera_move_limit_x_right)
	position.z = clamp(position.z, camera_move_limit_z_up, camera_move_limit_z_down)

# Moves the Camera_Base	
func camera_base_move(delta: float) -> void:
	#If we disable movement, immediately just skip
	if !camera_can_move_base:return
	
	var velocity_direction:Vector3 = Vector3.ZERO
	if Input.is_action_pressed("Camera_Up"): 
		if (position.z >= camera_move_limit_z_up):
			velocity_direction -= transform.basis.z
	if Input.is_action_pressed("Camera_Down"): 
		if (position.z <= camera_move_limit_z_down):
			velocity_direction += transform.basis.z
	if Input.is_action_pressed("Camera_Right"): 
		if (position.x <= camera_move_limit_x_right):
			velocity_direction += transform.basis.x
	if Input.is_action_pressed("Camera_Left"):
		if (position.x >= camera_move_limit_x_left):
			velocity_direction -= transform.basis.x
	
	#debug
	#print(velocity_direction)
	
	#actually change position
	position += (velocity_direction.normalized() * delta * camera_move_speed)

# Controls the Camera Zoom
func camera_zoom_update(delta:float) -> void:
	if !camera_can_zoom: return
	
	if (Input.is_action_pressed("Camera_Zoom_In")) or (Input.is_action_pressed("Camera_Zoom_Out")):
		if Input.is_action_pressed("Camera_Zoom_In"):
			camera_zoom_direction = -1	
		
		elif Input.is_action_pressed("Camera_Zoom_Out"):
			camera_zoom_direction = 1
		
		var new_zoom:float = clamp(position.y + camera_zoom_speed * camera_zoom_direction * delta, camera_zoom_min, camera_zoom_max) 
		position.y = new_zoom
		
		camera_zoom_current = new_zoom
		camera_zoom_direction *= camera_zoom_speed_damp
		
		#debug
		#print("Zoom Direction: " + str(camera_zoom_direction))
		#print("Zoom Current: " + str(camera_zoom_current))

func camera_automatic_pan(delta:float) -> void:
	if !camera_can_pan: return
	
	var viewport_current: Viewport = get_viewport()
	var pan_direction: Vector2 = Vector2(-1,-1) #Starts Negative
	var viewport_visible_rectangle: Rect2i = Rect2i(viewport_current.get_visible_rect())
	var viewport_size: Vector2i = viewport_visible_rectangle.size
	var current_mouse_position: Vector2 = viewport_current.get_mouse_position()
	
	# Detect Panning
		#For X
	if ((current_mouse_position.x < camera_automatic_pan_margin) or (current_mouse_position.x > viewport_size.x - camera_automatic_pan_margin)):
		#Check Limit
		
		#Debug
		#print("triggered")
		
		if (position.x >= camera_move_limit_x_left) and (position.x <= camera_move_limit_x_right):
			if current_mouse_position.x > viewport_size.x/2:
				pan_direction.x = 1
			translate(Vector3(pan_direction.x * delta * camera_automatic_pan_speed,0,0))
		
		#For Y (2D Vector)
	if ((current_mouse_position.y < camera_automatic_pan_margin) or (current_mouse_position.y > viewport_size.y - camera_automatic_pan_margin)):
		#Check Limit
		
		#Debug
		#print("triggered")
		
		if (position.z >= camera_move_limit_z_up) and (position.z <= camera_move_limit_z_down):
			if current_mouse_position.y > viewport_size.y/2:
				pan_direction.y = 1
			translate(Vector3(0, 0, pan_direction.y * delta * camera_automatic_pan_speed))
		
