class_name Entity

extends CharacterBody3D

# Get variables from Global
var gravity = Global.gravity
#Direction variables
var direction_x
var direction_z

#movement variables
var current_speed
#3.0 for default running
var acceleration
var decceleration
var air_decceleration
var max_speed

#States Variables
var current_state
var last_state = "idle_state"

#Get Current Player Directions
func get_direction_x():
	return direction_x

func get_direction_z():
	return direction_z

func update_gravity(delta, airtime):
	velocity.y -= (gravity + (airtime * 0.10)) * delta

func get_state():
	return current_state

#Get Player Speed
func get_speed():
	return current_speed

#Get Player Speed
func get_acceleration():
	return acceleration

#Get Player Speed
func get_decceleration():
	return decceleration

#set Max Speed
func set_max_speed(new_max_speed):
	max_speed = new_max_speed

func get_max_speed():
	return max_speed

#set Current Speed
func set_current_speed(new_current_speed):
	current_speed = new_current_speed
