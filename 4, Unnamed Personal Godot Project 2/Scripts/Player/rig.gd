extends Node

@onready var fps_rig_animator = $fps_rig_animator

func _ready():
	#Reference Self
	Global.rig = self
	#Play idle base
	fps_rig_animator.play("coilgun_idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
