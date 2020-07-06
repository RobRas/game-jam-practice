extends Node


signal horizontal_immediate(pressed, value)
signal jump_immediate(pressed)
signal grab_immediate(pressed)

const _UNSELECTED_CONTROLLER_SCENE = preload("res://Scenes/Controllers/UnselectedController.tscn")
const _PLAYER_CONTROLLER_SCENE = preload("res://Scenes/Controllers/PlayerController.tscn")

var _controller

enum ControllerType { UNSELECTED, PLAYER }
export(ControllerType) var controller_type = ControllerType.UNSELECTED
var _controllers

func _ready():
	_controllers = {
		ControllerType.UNSELECTED: _UNSELECTED_CONTROLLER_SCENE.instance(),
		ControllerType.PLAYER: _PLAYER_CONTROLLER_SCENE.instance()
	}
	_controller = _controllers[controller_type]
	add_child(_controller)

func set_controller(type):
	remove_child(_controller)
	if _controller.has_method("exit"):
		_controller.exit(self)
	_controller = _controllers[type]
	add_child(_controller)
	if _controller.has_method("enter"):
		_controller.enter(self)

func get_horizontal_movement():
	if _controller.has_method("get_horizontal_movement_input_continuous"):
		return _controller.get_horizontal_movement_input_continuous()
	return 0.0

func get_jump():
	if _controller.has_method("get_jump_input_continuous"):
		return _controller.get_jump_input_continuous()
	return false
