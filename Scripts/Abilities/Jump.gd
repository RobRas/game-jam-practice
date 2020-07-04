extends Node2D

signal jumped

signal enabled
signal disabled

export(int) var initial_jump_force = 20000

export(int) var hold_addition = 20000

export(int) var descent_addition = 30000

export(AudioStream) var jump_audio_stream
export(float) var volume_db = 8

export(NodePath) var ground_checker_path
export(NodePath) var animated_sprite_path

var controller
var parent
var ground_checker
var animated_sprite

var play_animation = false

var jumping = false
var _enabled = true

func _ready():
	$JumpAudio.stream = jump_audio_stream
	$JumpAudio.volume_db = volume_db
	
	ground_checker = get_node(ground_checker_path)
	ground_checker.connect("stopped_colliding", self, "_on_left_ground")
	ground_checker.connect("started_colliding", self, "_on_landed")
	
	animated_sprite = get_node(animated_sprite_path)

func init(parent, controller):
	self.parent = parent
	self.controller = controller
	
	self.controller.connect("jump_immediate", self, "_on_jump_immediate")


func _physics_process(delta):
	if jumping:
		# need to multiply by delta for acceleration
		if parent.velocity.y < 0 and controller.get_jump():
			parent.velocity.y -= hold_addition * delta
		if parent.velocity.y > 0: #falling
			parent.velocity.y += descent_addition * delta
		if $HeadCollisionChecker.is_colliding:
			if parent.velocity.y < 0:
				parent.velocity.y = 0

func jump():
	jumping = true
	parent.velocity.y = -initial_jump_force
	$JumpAudio.play()
	emit_signal("jumped")

func _on_left_ground():
	#annoying work around for animation
	if not jumping:
		return
	
	animated_sprite.play("Jump")

func _on_landed():
	jumping = false
	animated_sprite.stop()

func set_enabled(enabled):
	_enabled = enabled
	if not _enabled:
		parent.velocity.y = min(0, parent.velocity.y)
		jumping = false
		emit_signal("disabled")
	else:
		emit_signal("enabled")

func _on_jump_immediate(pressed):
	if pressed and ground_checker.is_colliding:
		jump()
