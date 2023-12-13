extends Area3D

#Setup
#Exported
@export var Hotspot_Name = ""
@export var Hotspot_ID = ""

#Textures Preloaded

#Middle East
#Base
var IRM_tex = preload("res://Board/Materials/Hotspot/Iram_Material.tres")
var ARE_tex = preload("res://Board/Materials/Hotspot/ArabEmi_Material.tres")
var JER_tex = preload("res://Board/Materials/Hotspot/JeruRuins_Material.tres")
var BBL_tex = preload("res://Board/Materials/Hotspot/Babel_Material.tres")
#Selected
var IRM_tex_selected = preload("res://Board/Materials/Hotspot/Iram_Material_Selected.tres")
var ARE_tex_selected = preload("res://Board/Materials/Hotspot/ArabEmi_Material_Selected.tres")
var JER_tex_selected = preload("res://Board/Materials/Hotspot/JeruRuins_Material_Selected.tres")
var BBL_tex_selected = preload("res://Board/Materials/Hotspot/Babel_Material_Selected.tres")

#Inbult
@onready var Hotspot_Texture_Node = self.get_node("Hotspot_Image")

# Called when the node enters the scene tree for the first time.
func hotspot_setup():
	
	#Set Texture
	#Pain
	if Hotspot_ID == "ARE":
		Hotspot_Texture_Node.set_material_override(ARE_tex)
	elif Hotspot_ID == "IRM":
		Hotspot_Texture_Node.set_material_override(IRM_tex)
	elif Hotspot_ID == "JER":
		Hotspot_Texture_Node.set_material_override(JER_tex)
	elif Hotspot_ID == "BBL":
		Hotspot_Texture_Node.set_material_override(BBL_tex)
	else:
		pass
	
	#Debug
	#print(Hotspot_Texture_Node)

func _on_mouse_entered():
	#debug
	#print("Mouse Entered")
	#print("Hotspot Name: " + Hotspot_Name)
	#print("Hotspot ID: " + Hotspot_ID)
	
	#Debug
	#Pain
	if Hotspot_ID == "ARE":
		Hotspot_Texture_Node.set_material_override(ARE_tex_selected)
	elif Hotspot_ID == "IRM":
		Hotspot_Texture_Node.set_material_override(IRM_tex_selected)
	elif Hotspot_ID == "JER":
		Hotspot_Texture_Node.set_material_override(JER_tex_selected)
	elif Hotspot_ID == "BBL":
		Hotspot_Texture_Node.set_material_override(BBL_tex_selected)
	else:
		pass
	
	#Debug
	#print(node)
	
func _on_mouse_exited():
	
	#debug
	#print("Mouse Exited " + Hotspot_Name)
	
	#Pain
	if Hotspot_ID == "ARE":
		Hotspot_Texture_Node.set_material_override(ARE_tex)
	elif Hotspot_ID == "IRM":
		Hotspot_Texture_Node.set_material_override(IRM_tex)
	elif Hotspot_ID == "JER":
		Hotspot_Texture_Node.set_material_override(JER_tex)
	elif Hotspot_ID == "BBL":
		Hotspot_Texture_Node.set_material_override(BBL_tex)
	else:
		pass

func set_region_ID(region_name, id):
	Hotspot_Name = region_name
	Hotspot_ID = id
	
	hotspot_setup()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
