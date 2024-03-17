extends PanelContainer

@export var property_container : VBoxContainer

func _ready():
	#Global reference
	Global.debug_panel = self
	
	#visible from start
	visible = false

func _input(event):
	#Toggle on or off
	if event.is_action_pressed("debug_panel"):
		visible = !visible

func add_property(title: String, value, order):
	var target
	#Find if said target exists
	target = property_container.find_child(title, true, false)
	#if target is new
	if !target: 
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible:
		target.text = title + ": " + str(value)
		property_container.move_child(target, order)
