extends Node2D

export(float) var grab_cooldown = 0.4

export(NodePath) var jump_path
var jump

export(Array, NodePath) var enable_setter_paths
var enable_setters = []

var can_climb = true
var climbing = false

var parent

func _ready():
	$GrabCooldown.wait_time = grab_cooldown
	jump = get_node(jump_path)
	for setter_path in enable_setter_paths:
		enable_setters.append(get_node(setter_path))

func init(parent):
	self.parent = parent

func _process(delta):
	if climbing:
		if Input.is_action_just_pressed("jump"):
			_stop_climb()
			jump.jump()

func _physics_process(delta):
	if not climbing:
		if can_climb and Input.is_action_just_pressed("grab"):
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
	can_climb = false
	$GrabCooldown.start()

func _set_enables(enabled):
	for enable_setter in enable_setters:
		enable_setter.set_enabled(enabled)


func _on_GrabCooldown_timeout():
	can_climb = true
