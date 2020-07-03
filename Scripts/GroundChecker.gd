extends Node2D


signal left_ground
signal landed

var is_grounded = false


func _physics_process(delta):
	var was_grounded_last_frame = is_grounded
	is_grounded = $GroundCheckerLeft.is_colliding() or $GroundCheckerRight.is_colliding()
	
	if was_grounded_last_frame != is_grounded:
		if is_grounded:
			emit_signal("landed")
		else:
			emit_signal("left_ground")
