extends Node2D

export(int) var initial_jump_force = 20000

export(int) var hold_addition = 20000

export(int) var descent_addition = 30000

export(NodePath) var ground_checker_path
export(NodePath) var animated_sprite_path

export(AudioStream) var jump_audio_stream

var parent
var ground_checker
var animated_sprite

var play_animation = false

var controlled = false

var jumping = false

func _ready():
	ground_checker = get_node(ground_checker_path)
	ground_checker.connect("stopped_colliding", self, "_on_left_ground")
	ground_checker.connect("started_colliding", self, "_on_landed")
	animated_sprite = get_node(animated_sprite_path)
	
	if jump_audio_stream:
		$JumpAudio.stream = jump_audio_stream

func init(parent):
	self.parent = parent

func _process(delta):
	if not controlled:
		return
	
	if Input.is_action_just_pressed("jump") and ground_checker.is_colliding:
		jump()

func _physics_process(delta):
	if jumping:
		# need to multiply by delta for acceleration
		if Input.is_action_pressed("jump"):
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

func _on_left_ground():
	#annoying work around for animation
	if not jumping:
		return
	
	animated_sprite.play("Jump")

func _on_landed():
	jumping = false
	animated_sprite.stop()

func _on_control_enabled(_mole):
	controlled = true

func _on_control_disabled(_mole):
	controlled = false
