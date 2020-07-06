extends Node

var _horizontal_movement_input = 0.0
var _jump_input = false
var _climb_start_input = false
var _climb_release_input = false
var _climb_vertical_movement = 0.0

var _character_controller

func _process(delta):
	_process_horizontal_movement_input()
	_process_jump_input()
	_process_climb_start_input()
	_process_climb_release_input()
	_process_climb_vertical_movement_input()

func _process_horizontal_movement_input():
	_horizontal_movement_input = _process_ternary_input("horizontal", "move_left", "move_right")

func _process_jump_input():
	_jump_input = _process_binary_input("jump")

func _process_climb_start_input():
	_climb_start_input = _process_binary_input("climb_start")

func _process_climb_release_input():
	_climb_release_input = _process_binary_input("climb_release")

func _process_climb_vertical_movement_input():
	_climb_vertical_movement = _process_ternary_input("climb_vertical", "climb_up", "climb_down")



func _process_binary_input(input_name):
	if Input.is_action_just_pressed(input_name):
		_character_controller.emit_signal(input_name + "_immediate", true)
	elif Input.is_action_just_released(input_name):
		_character_controller.emit_signal(input_name + "_immediate", false)
	return Input.is_action_pressed(input_name)

func _process_ternary_input(base_name, negative_name, positive_name):
	var value = 0
	
	if Input.is_action_pressed(negative_name):
		value -= 1
	if Input.is_action_pressed(positive_name):
		value += 1
	
	if Input.is_action_just_pressed(negative_name) or Input.is_action_just_pressed(positive_name):
		_character_controller.emit_signal(base_name + "_immediate", true, value)
	elif Input.is_action_just_released(negative_name) or Input.is_action_just_released(positive_name):
		_character_controller.emit_signal(base_name + "_immediate", false, value)
	
	return value


func get_horizontal_movement_input_continuous():
	return _horizontal_movement_input

func get_jump_input_continuous():
	return _jump_input

func get_climb_start_input_continuous():
	return _climb_start_input

func get_climb_release_input_continuous():
	return _climb_release_input

func get_climb_vertical_movement_input_continuous():
	return _climb_vertical_movement


func enter(character_controller):
	_character_controller = character_controller
	set_process(true)

func exit(character_controller):
	set_process(false)
