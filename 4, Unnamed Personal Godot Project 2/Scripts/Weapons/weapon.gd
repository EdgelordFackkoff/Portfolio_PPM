class_name weapon

extends Node

#Light, Medium, Heavy
var type = ""
#Various types
var ammo = ""
#Integer for amount of ammo
#capacity is per shot, reserve is shots that can be stored for later
#0 is special, meant for weapons without reloading or melee weaponry
var capacity = 0
var reserve = 0
#Weapon slot number
var slot = 0
#Active
var active
