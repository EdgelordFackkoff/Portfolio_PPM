class_name Cooking_Grounds

extends Level

@export var player: CharacterBody3D

func _ready():

	#Reference self Global
	Global.level_cooking_ground = self
	
	#Set Gravity
	Global.gravity = 9.8
	
	#Set Up
	menu = false
	ingame = true
	
	#Remove Mouse
	remove_mouse()
