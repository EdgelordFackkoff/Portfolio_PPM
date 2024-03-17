class_name State_Machine

extends Node

@export var current_state : State
var states: Dictionary = {}

func _ready():
	#for debug
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transition.connect(on_child_transition)
		else:
			print("Incompatible Child Node")
	current_state.enter()

#Loop and call the state's basic update
func _process(delta):
	current_state.update(delta)

func _physics_process(delta):
	current_state.physics_update(delta)

func get_current_state():
	return current_state

func error_message():
	print("State doesn't exist")

#Transition between states
func on_child_transition(new_state_name) -> void:
	#get state name
	var new_state = states.get(new_state_name)
	#check if not null for new state
	if new_state != null:
			#Detect if new state is like the old
			if new_state != current_state:
				#Change to new state
				current_state.exit()
				new_state.enter()
				current_state = new_state
	else:
		error_message()
