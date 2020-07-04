extends Node2D

export(float) var grab_cooldown = 0.4
export(int) var walljump_initial_force = 1000

export(NodePath) var jump_path
var jump

export(Array, NodePath) var enable_setter_paths
var enable_setters = []

var climb_on_cooldown = false
var climbing = false

var parent
var controller

func _ready():
	$GrabCooldown.wait_time = grab_cooldown
	jump = get_node(jump_path)
	for setter_path in enable_setter_paths:
		enable_setters.append(get_node(setter_path))

func init(parent, controller):
	self.parent = parent
	self.controller = controller
	controller.connect("grab_immediate", self, "_on_grab_immediate")
	controller.connect("jump_immediate", self, "_on_jump_immediate")


func _start_climb():
	climbing = true
	_set_enables(false)

func _stop_climb():
	climbing = false
	_set_enables(true)
	climb_on_cooldown = true
	$GrabCooldown.start()

func _set_enables(enabled):
	for enable_setter in enable_setters:
		enable_setter.set_enabled(enabled)


func _on_GrabCooldown_timeout():
	climb_on_cooldown = false

func _on_grab_immediate(pressed):
	if not pressed:
		return
		
	if climbing:
		_stop_climb()
	elif not climb_on_cooldown and $CollisionChecker.is_colliding:
		_start_climb()

func _on_jump_immediate(pressed):
	if not pressed:
		return
	
	if climbing:
		_stop_climb()
		jump.jump()
		parent.velocity.x = controller.get_horizontal_movement() * walljump_initial_force
