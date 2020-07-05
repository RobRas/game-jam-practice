extends Node

signal enabled
signal disabled

export(int) var move_speed = 12000
export(int) var start_acceleration = 500
export(int) var stop_acceleration = 500

export(NodePath) var ground_checker_path
export(NodePath) var sprite_controller_path

export(AudioStream) var run_audio_stream
export(float) var volume_db = 20

var _sprite_controller

var _parent
var _ground_checker


func _ready():
	_sprite_controller = get_node(sprite_controller_path)
	_ground_checker = get_node(ground_checker_path)
	
	_ground_checker.connect("started_colliding", self, "_on_ground_collision_started")
	_ground_checker.connect("stopped_colliding", self, "_on_ground_collision_stopped")
	
	get_run_audio().set_stream(run_audio_stream)
	get_run_audio().set_db(volume_db)

func init(parent, controller):
	_parent = parent
	$States.init(self, controller)


func get_velocity():
	return _parent.velocity.x

func set_velocity(value):
	_parent.velocity.x = value


func get_sprite_controller():
	return _sprite_controller

func get_run_audio():
	return $RunAudio


func enable():
	print("ENABLE")
	if _ground_checker.is_colliding:
		emit_signal("enabled")
	else:
		disable()

func disable():
	print("DISABLE")
	emit_signal("disabled")


func _on_ground_collision_started():
	enable()

func _on_ground_collision_stopped():
	disable()
