extends Node2D

signal enabled
signal disabled

export(int) var initial_jump_force = 20000
export(int) var hold_addition = 20000
export(int) var descent_addition = 30000

export(AudioStream) var jump_audio_stream
export(float) var volume_db = 8

export(NodePath) var ground_checker_path
export(NodePath) var sprite_controller_path

var _parent

var _ground_checker
var _sprite_controller

var _enabled

func _ready():
	_ground_checker = get_node(ground_checker_path)
	_sprite_controller = get_node(sprite_controller_path)
	
	_ground_checker.connect("started_colliding", self, "_on_ground_checker_collided")
	
	get_jump_audio().stream = jump_audio_stream
	get_jump_audio().volume_db = volume_db

func init(parent, controller):
	_parent = parent
	$States.init(self, controller)


func get_velocity():
	return _parent.velocity.y

func set_velocity(new_velocity):
	_parent.velocity.y = new_velocity

func get_sprite_controller():
	return _sprite_controller

func get_jump_audio():
	return $JumpAudio

func get_ground_checker():
	return _ground_checker

func enable():
	if not _enabled:
		print("jump enabled")
		_enabled = true
		emit_signal("enabled")

func disable():
	if _enabled:
		print("jump disabled")
		_enabled = false
		emit_signal("disabled")

func _on_ground_checker_collided():
	enable()
