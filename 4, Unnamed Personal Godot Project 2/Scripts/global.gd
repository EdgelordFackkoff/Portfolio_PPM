extends Node

#Debug Panel
var debug_panel

#Gameplay Variables
var mouse_sens = 0.03
var fov = 75.0

#Levels Variables
var gravity = 9.8 #default gravity unless stated otherwise
var level_cooking_ground = null

#Rig variables
var rig = null

#Quick Colission Layers Guide
#To help myself in the future: Add the results of 2 to the power of (layer to be enabled - 1).
var col_wall = 1024
var col_floor = 2048
var col_objects = 4096

#Player variables
var player = null
var player_states = null
var player_animation_player = null
