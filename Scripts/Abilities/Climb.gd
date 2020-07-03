extends Node2D

export(Array, NodePath) var enable_setter_paths
var enable_setters = []

var climbing = false

var parent

func _ready():
	for setter_path in enable_setter_paths:
		enable_setters.append(get_node(setter_path))

func init(parent):
	self.parent = parent

func _physics_process(delta):
	if not climbing:
		if Input.is_action_just_pressed("grab"):
			if $CollisionChecker.is_colliding:
				_start_climb()
	else:
		if Input.is_action_just_pressed("grab"):
			_stop_climb()

func _start_climb():
	climbing = true
	_set_enables(false)

func _stop_climb():
	climbing = false
	_set_enables(true)

func _on_jumped():
	if climbing:
		_stop_climb()

func _set_enables(enabled):
	for enable_setter in enable_setters:
		enable_setter.set_enabled(enabled)
