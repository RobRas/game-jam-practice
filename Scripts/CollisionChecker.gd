extends Node2D


signal stopped_colliding
signal started_colliding

var rays
var is_colliding = false


func _ready():
	rays = get_children()

func _physics_process(delta):
	var was_collided_last_frame = is_colliding
	
	for ray in rays:
		if ray.is_colliding():
			is_colliding = true
			if not was_collided_last_frame:
				emit_signal("started_colliding")
			return
	
	is_colliding = false
	if was_collided_last_frame:
		emit_signal("stopped_colliding")
