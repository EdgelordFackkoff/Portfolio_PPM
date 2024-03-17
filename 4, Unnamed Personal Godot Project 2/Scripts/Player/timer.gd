extends Node

@onready var timer_charge_cooldown = $timer_charge
@onready var timer_unmoveable_charged = $timer_unmoveable_charged

func _ready():
	#Pause all timers
	timer_charge_cooldown.set_paused(true)
	timer_unmoveable_charged.set_paused(true)

# Call Timers
#Unmoveable from Charge Timer
func _timer_unmoveable_charged():
	#Start/Restart Timer
	timer_unmoveable_charged.set_paused(false)
	timer_unmoveable_charged.start(1)
	
func _on_timer_unmoveable_charged_timeout():
	#Stop Timer
	timer_unmoveable_charged.set_paused(true)
	#Allow movement again
	Global.player._allowmovement()

#Charge Timer
func _timer_charge():
	#Restart Timer
	timer_charge_cooldown.set_paused(false)
	timer_charge_cooldown.start(10)
	
func _on_timer_charge_timeout():
	#Stop Timer
	timer_charge_cooldown.set_paused(true)
	#Reset Charge
	Global.player._resetcharge()
