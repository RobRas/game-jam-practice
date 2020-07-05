extends KinematicBody2D


signal enabled(mole)
signal disabled(mole)

signal hazard_hit(hazard)

var velocity = Vector2()

var enabled = false


func _physics_process(delta):
	move_and_slide(velocity * delta)

func set_character_controller(type):
	$CharacterController.set_controller(type)

func hazard_hit(hazard):
	emit_signal("hazard_hit", hazard)


func enable(enabled):
	if enabled:
		emit_signal("enabled", self)
	else:
		emit_signal("disabled", self)
