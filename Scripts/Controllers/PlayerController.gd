extends Node

var _horizontal_movement_input
var _jump_input
var _grab_input

var _character_controller

func _process(delta):
	_process_horizontal_movement_input()
	_process_jump_input()
	_process_grab_input()

func _process_horizontal_movement_input():
	_horizontal_movement_input = 0
	if Input.is_action_pressed("move_left"):
		_horizontal_movement_input -= 1
	if Input.is_action_pressed("move_right"):
		_horizontal_movement_input += 1
	
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		_character_controller.emit_signal("horizontal_immediate", true, _horizontal_movement_input)
	elif Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		_character_controller.emit_signal("horizontal_immediate", false, _horizontal_movement_input)

func _process_jump_input():
	if Input.is_action_just_pressed("jump"):
		_character_controller.emit_signal("jump_immediate", true)
	elif Input.is_action_just_released("jump"):
		_character_controller.emit_signal("jump_immediate", false)
	
	_jump_input = Input.is_action_pressed("jump")

func _process_grab_input():
	if Input.is_action_just_pressed("grab"):
		_character_controller.emit_signal("grab_immediate", true)
	elif Input.is_action_just_released("grab"):
		_character_controller.emit_signal("grab_immediate", false)
	
	_grab_input = Input.is_action_pressed("grab")
	
	
	

func get_horizontal_movement_input_continuous():
	return _horizontal_movement_input

func get_jump_input_continuous():
	return _jump_input

func get_grab_input_continuous():
	return _grab_input


func enter(character_controller):
	_character_controller = character_controller
	set_process(true)

func exit(character_controller):
	set_process(false)
