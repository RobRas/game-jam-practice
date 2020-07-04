extends Node

var _horizontal_movement_input
var _jump_input_immediate
var _jump_input_continuous


func _process(delta):
	_proces_horizontal_movement_input()
	_process_jump_input()

func _proces_horizontal_movement_input():
	_horizontal_movement_input = 0
	if Input.is_action_pressed("move_left"):
		_horizontal_movement_input -= 1
	if Input.is_action_pressed("move_right"):
		_horizontal_movement_input += 1

func _process_jump_input():
	_jump_input_immediate = Input.is_action_just_pressed("jump")
	_jump_input_continuous = Input.is_action_pressed("jump")

func get_horizontal_movement_input():
	return _horizontal_movement_input

func get_jump_input_immediate():
	return _jump_input_immediate

func get_jump_input_continuous():
	return _jump_input_continuous
