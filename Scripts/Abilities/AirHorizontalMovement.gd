extends Node

signal enabled
signal disabled

export(NodePath) var ground_horizontal_movement_path
var _ground_horizontal_movement

export(NodePath) var ground_checker_path
var _ground_checker

var _parent
var _controller

var _enabled

func _ready():
	_ground_checker = get_node(ground_checker_path)
	_ground_checker.connect("started_colliding", self, "_on_ground_started_colliding")
	_ground_checker.connect("stopped_colliding", self, "_on_ground_stopped_colliding")
	
	_ground_horizontal_movement = get_node(ground_horizontal_movement_path)

func _physics_process(delta):
	if not _enabled:
		return
	
	var input_direction = _controller.get_horizontal_movement()
	if input_direction != 0:
		_parent.velocity.x = _ground_horizontal_movement.calculate_velocity(input_direction)

func init(parent, controller):
	_parent = parent
	_controller = controller

func set_enabled(enabled):
	if enabled:
		if not _ground_checker.is_colliding:
			_enabled = true
			emit_signal("enabled")
			return
	
	_enabled = false
	emit_signal("disabled")

func _on_ground_started_colliding():
	set_enabled(false)

func _on_ground_stopped_colliding():
	set_enabled(true)
