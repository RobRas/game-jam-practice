extends Node

var _attempting_climb

func enter(character_controller):
	_attempting_climb = Input.is_action_pressed("grab")

func get_climb_input_continuous():
	return _attempting_climb
