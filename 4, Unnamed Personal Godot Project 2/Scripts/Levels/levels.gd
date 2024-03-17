extends Node

class_name Level

#variables
#by default all to false
var menu = false
var ingame = false
var last_fps

func remove_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	#Get fps
	var new_fps = "%.2f" % (1.0/delta)
	#Check if same
	if last_fps != new_fps:
		Global.debug_panel.add_property("FPS", new_fps, 0)
		last_fps = new_fps
