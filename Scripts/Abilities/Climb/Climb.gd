extends Node2D

signal enabled
signal disabled

export(int) var climb_speed = 10000
export(int) var wall_jump_initial_force = 1000
export(float) var grab_cooldown = 0.4

export(Array, NodePath) var to_disable_on_grab_path
var to_disable_on_grab = []

var _parent

var _enabled

func _ready():
	for to_disable_path in to_disable_on_grab_path:
		to_disable_on_grab.append(get_node(to_disable_path))

func init(parent, controller):
	_parent = parent
	$States.init(self, controller)
	enable()


func set_disables_on_grab(disabled):
	if disabled:
		for disable_node in to_disable_on_grab:
			disable_node.disable()
	else:
		for enable_node in to_disable_on_grab:
			enable_node.enable()


func get_velocity():
	return _parent.velocity.y

func set_velocity(new_velocity):
	_parent.velocity.y = new_velocity


func get_climb_speed():
	return climb_speed

func get_collision_checker():
	return $CollisionChecker


func get_grab_timer_cooldown():
	return grab_cooldown


func enable():
	if not _enabled:
		_enabled = true
		emit_signal("enabled")
	else:
		disable()

func disable():
	if _enabled:
		_enabled = false
		emit_signal("disabled")
