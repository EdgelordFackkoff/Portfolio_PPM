extends CenterContainer

#Reticle Variables
var dot_radius = 2.0
var dot_color = Color.WHITE
var reticle_speed = 0.10
var reticle_distance = 2.0

#Coilcarbine Lines
@export var reticle_lines: Array[Line2D]

#ready
func _ready():
	queue_redraw()

#reprocess
func _process(delta):
	adjust_reticle_lines()

#draw reticle
func _draw():
	draw_circle(Vector2(0,0),dot_radius,dot_color)

func adjust_reticle_lines():
	#grab the speed from the player controller
	var vel = Global.player.get_real_velocity()
	#Get origin point
	var origin = Vector3(0,0,0)
	var pos = Vector2(0,0)
	#Get distance traveled
	var speed = origin.distance_to(vel)
	#Adjust reticle lines
	#Top, Right Bottom Left
	reticle_lines[0].position = lerp(reticle_lines[0].position, pos + Vector2(0, -speed * reticle_distance), reticle_speed)
	reticle_lines[1].position = lerp(reticle_lines[1].position, pos + Vector2(speed * reticle_distance, 0), reticle_speed)
	reticle_lines[2].position = lerp(reticle_lines[2].position, pos + Vector2(0, speed * reticle_distance), reticle_speed)
	reticle_lines[3].position = lerp(reticle_lines[3].position, pos + Vector2(-speed * reticle_distance, 0), reticle_speed)
