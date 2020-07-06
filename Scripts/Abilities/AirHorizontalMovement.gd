extends Node

signal enabled
signal disabled

export(int) var move_speed = 12000
export(int) var acceleration = 500

export(NodePath) var ground_checker_path
var _ground_checker

export(NodePath) var sprite_controller_path
var _sprite_controller

var _parent

var _enabled

func _ready():
	_ground_checker = get_node(ground_checker_path)
	_ground_checker.connect("started_colliding", self, "_on_ground_started_colliding")
	_ground_checker.connect("stopped_colliding", self, "_on_ground_stopped_colliding")
	
	_sprite_controller = get_node(sprite_controller_path)

func init(parent, controller):
	_parent = parent
	$States.init(self, controller)

func get_velocity():
	return _parent.velocity.x

func set_velocity(value):
	_parent.velocity.x = value


func get_sprite_controller():
	return _sprite_controller

func enable():
	if not _ground_checker.is_colliding and not _enabled:
		_enabled = true
		emit_signal("enabled")
	else:
		disable()

func disable():
	if _enabled:
		_enabled = false
		emit_signal("disabled")

func _on_ground_started_colliding():
	disable()

func _on_ground_stopped_colliding():
	enable()
