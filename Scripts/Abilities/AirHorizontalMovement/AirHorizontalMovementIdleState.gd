extends "res://Scripts/Abilities/StateMachine/State.gd"

func _set_state(input):
	if input == 0:
		return
	
	if sign(input) == sign(_manager.get_velocity()):
		if (abs(_manager.get_velocity()) == _manager.get_move_speed()):
			transition(_manager.States.MOVING)
		else:
			transition(_manager.States.STARTING)
	else:
		transition(_manager.States.TURNING)
