class_name coil_carbine

extends weapon

#Set up
func _ready():
	type = "light"
	ammo = "coil_slug"
	capacity = 10
	reserve = 60
	slot = 1
	#Start default false, for now true
	active = true

	#Set Up
	for child in get_children():
		if child is Node:
			var child_name = child.name
			if child_name == "player":
				print('Player has Coil_Carbine')
