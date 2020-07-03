extends Node

export(int) var move_speed = 12000
export(int) var move_start_growth = 500
export(int) var move_stop_growth = 500
export(NodePath) var ground_checker_path
export(NodePath) var animated_sprite_path
export(AudioStream) var run_audio_stream

var parent
var ground_checker
var animated_sprite

var facing_right = true
var running = false

var controlled = false
var _enabled = true

func _ready():
	ground_checker = get_node(ground_checker_path)
	animated_sprite = get_node(animated_sprite_path)
	
	if run_audio_stream:
		$RunAudio.stream = run_audio_stream

func init(parent):
	self.parent = parent

func _process(delta):
	if not _enabled:
		return
	
	if not controlled:
		if ground_checker.is_colliding:
			parent.velocity.x = 0
		return
	
	_parse_horizontal_input()

func _parse_horizontal_input():
	var input_direction = 0
	
	if Input.is_action_pressed("move_left"):
		if facing_right:
			facing_right = false
			parent.scale.x = -parent.scale.x
		input_direction -= 1
	elif Input.is_action_pressed("move_right"):
		if not facing_right:
			facing_right = true
			parent.scale.x = -parent.scale.x
		input_direction += 1
		
	
	if input_direction == 0:
		var current_velocity_direction = sign(parent.velocity.x)
		var deceleration = -current_velocity_direction * move_stop_growth
		var calculated_velocity = parent.velocity.x + deceleration
		var clamped_velocity = max(abs(calculated_velocity), 0)
		parent.velocity.x = current_velocity_direction * clamped_velocity
	else:
		var acceleration = input_direction * move_start_growth
		var calculated_velocity = parent.velocity.x + acceleration
		var clamped_velocity = clamp(calculated_velocity, -move_speed, move_speed)
		parent.velocity.x = clamped_velocity
	
	if ground_checker.is_colliding and input_direction != 0:
		if not running:
			$RunAudio.play()
			animated_sprite.play("Run")
			running = true
	else:
		$RunAudio.stop()
		animated_sprite.stop()
		running = false


func _on_control_enabled(_mole):
	controlled = true

func _on_control_disabled(_mole):
	controlled = false
	if running:
		animated_sprite.stop()

func set_enabled(enabled):
	_enabled = enabled
	if not _enabled:
		parent.velocity.x = 0
		$RunAudio.stop()
		animated_sprite.stop()
