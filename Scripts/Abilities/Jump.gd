extends Node

export(int) var jump_speed = 14000
export(NodePath) var ground_checker_path
export(NodePath) var animated_sprite_path

export(AudioStream) var jump_audio_stream

var parent
var ground_checker
var animated_sprite

var play_animation = false

var controlled = false

func _ready():
	ground_checker = get_node(ground_checker_path)
	ground_checker.connect("left_ground", self, "_on_left_ground")
	animated_sprite = get_node(animated_sprite_path)
	
	if jump_audio_stream:
		$JumpAudio.stream = jump_audio_stream

func init(parent):
	self.parent = parent

func _process(delta):
	if not controlled:
		return
	
	if Input.is_action_just_pressed("jump") and ground_checker.is_grounded:
		jump()

func jump():
	parent.velocity.y = -jump_speed
	$JumpAudio.play()
	play_animation = true

func _on_left_ground():
	#annoying work around for animation
	if not play_animation:
		return
	
	animated_sprite.play("Jump")
	play_animation = false

func _on_control_enabled(_mole):
	controlled = true

func _on_control_disabled(_mole):
	controlled = false
