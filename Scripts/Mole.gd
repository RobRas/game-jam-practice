extends KinematicBody2D


signal enabled(mole)
signal disabled(mole)

signal hazard_hit(hazard)

var velocity = Vector2()

var enabled = false

func _ready():
	for ability in $Abilities.get_children():
		ability.init(self)


func _physics_process(delta):
	move_and_slide(velocity * delta)


func hazard_hit(hazard):
	emit_signal("hazard_hit", hazard)

func enable(enabled):
	if enabled:
		emit_signal("enabled", self)
	else:
		emit_signal("disabled", self)
