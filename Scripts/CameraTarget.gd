extends Node2D

export(float) var movement_weight = 0.75

var follow_target


func _process(delta):
	position = lerp(position, follow_target.position, movement_weight)
