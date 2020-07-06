tool

extends KinematicBody2D


signal enabled(mole)
signal disabled(mole)

signal hazard_hit(hazard)


export(SpriteFrames) var animation_frames


var velocity = Vector2()

var enabled = false


func _ready():
	$Abilities.init()
	$SpriteController/AnimatedSprite.frames = animation_frames

func _process(delta):
	if Engine.editor_hint:
		$SpriteController/AnimatedSprite.frames = animation_frames

func _physics_process(delta):
	if not Engine.editor_hint:
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
