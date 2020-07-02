extends KinematicBody2D


signal enabled(mole)
signal disabled(mole)

var velocity = Vector2()

var enabled = false

func _ready():
	for ability in $Abilities.get_children():
		ability.init(self)


func _physics_process(delta):
	move_and_slide(velocity * delta)


func hazard_hit():
	print("ow")
	$Audio/DeathAudio.play()


func enable(enabled):
	if self.enabled == enabled:
		return

	self.enabled = enabled
	if self.enabled:
		emit_signal("enabled", self)
		var tween = $SelectionTween

		var scale_size = 1.1
		tween.interpolate_property($SpriteScaling, "scale", Vector2(1, 1), Vector2(scale_size, scale_size), 0.08, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
		yield(tween, "tween_completed")
		tween.interpolate_property($SpriteScaling, "scale", Vector2(scale_size, scale_size), Vector2(1, 1), 0.08, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	else:
		emit_signal("disabled", self)
