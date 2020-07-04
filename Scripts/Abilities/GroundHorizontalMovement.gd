extends Node

signal enabled
signal disabled

export(int) var move_speed = 12000
export(int) var move_start_growth = 500
export(int) var move_stop_growth = 500
export(NodePath) var ground_checker_path
export(NodePath) var animated_sprite_path
export(AudioStream) var run_audio_stream
export(float) var volume_db = 20

var controller

var parent
var ground_checker
var animated_sprite

var facing_right = true
var running = false

var _enabled = true

func _ready():
	$RunAudio.volume_db = volume_db
	
	ground_checker = get_node(ground_checker_path)
	ground_checker.connect("started_colliding", self, "_on_started_colliding")
	ground_checker.connect("stopped_colliding", self, "_on_stopped_colliding")
	
	animated_sprite = get_node(animated_sprite_path)
	

func init(parent, controller):
	self.parent = parent
	self.controller = controller

func _process(_delta):
	if not _enabled:
		return
	
	if not ground_checker.is_colliding:
		return
	
	var input_direction = controller.get_horizontal_movement()
	var new_horizontal_velocity = calculate_velocity(input_direction)
	set_effects(input_direction)
	parent.velocity.x = new_horizontal_velocity



func calculate_velocity(input_direction):
	if input_direction < 0 and facing_right:
		facing_right = false
		parent.scale.x = -parent.scale.x
	elif input_direction > 0 and not facing_right:
		facing_right = true
		parent.scale.x = -parent.scale.x
		
	var new_velocity
	if input_direction == 0:
		new_velocity = _calculate_stop_momentum()
	else:
		new_velocity = calculate_movement_momentum(input_direction)
	
	return new_velocity
	
func set_effects(input_direction):
	if ground_checker.is_colliding and input_direction != 0:
		if not running:
			$RunAudio.play()
			animated_sprite.play("Run")
			running = true
	else:
		$RunAudio.stop()
		animated_sprite.stop()
		running = false

func _calculate_stop_momentum():
	var current_velocity_direction = sign(parent.velocity.x)
	var deceleration = -current_velocity_direction * move_stop_growth
	var calculated_velocity = parent.velocity.x + deceleration
	var clamped_velocity = max(abs(calculated_velocity), 0)
	return current_velocity_direction * clamped_velocity

func calculate_movement_momentum(input_direction):
	var acceleration = input_direction * move_start_growth
	var calculated_velocity = parent.velocity.x + acceleration
	return clamp(calculated_velocity, -move_speed, move_speed)

func set_enabled(enabled):
	_enabled = enabled
	if not _enabled:
		$RunAudio.stop()
		animated_sprite.stop()
		emit_signal("disabled")
	else:
		emit_signal("enabled")

func _on_started_colliding():
	set_enabled(true)

func _on_stopped_colliding():
	set_enabled(false)
