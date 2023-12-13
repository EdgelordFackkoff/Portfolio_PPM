extends Node3D

#Setup
@export var Hotspot_Name = ""
@export var Hotspot_ID = ""
@export var Hotspot_Parent_Region_ID = ""

#Inbult
@onready var Hotspot_Node = self.get_node("Hotspot_Node")

# Called when the node enters the scene tree for the first time.
func _ready():
	Hotspot_Node.set_region_ID(Hotspot_Name, Hotspot_ID)
