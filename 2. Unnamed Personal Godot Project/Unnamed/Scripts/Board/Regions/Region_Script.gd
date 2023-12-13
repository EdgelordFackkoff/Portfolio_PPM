extends Area3D

#Setup
@export var Region_Name = ""
@export var Region_ID = ""
@export var Region_Child_Node = ""

#Some Imports
var bluetex = preload("res://Board/Shaders/Hologram_Blue.tres")
var bluetexhover = preload("res://Board/Shaders/Hologram_Blue_Selected.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _mouse_enter():
	#debug
	#print("Mouse Entered")
	#print("Region Name: " + Region_Name)
	#print("Region ID: " + Region_ID)
	
	#Material Change
	var node = self.get_node(Region_Child_Node)
	node.set_material_override(bluetexhover)
	
	#Slight Elevation
	position.y += 0.001
	
	#Debug
	#print(node)
	
func _mouse_exit():
	
	#debug
	#print("Mouse Exited " + Region_Name)
	
	#Material Change
	var node = self.get_node(Region_Child_Node)
	node.set_material_override(bluetex)
	
	#Reset Elevation
	position.y -= 0.001
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
