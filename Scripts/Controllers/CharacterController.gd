extends Node


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
	_controller = _controllers[type]
	add_child(_controller)

func get_horizontal_movement_input():
	return _controller.get_horizontal_movement_input()

func get_jump_input_immediate():
	return _controller.get_jump_input_immediate()

func get_jump_input_continuous():
	return _controller.get_jump_input_continuous()
