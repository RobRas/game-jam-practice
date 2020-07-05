extends "res://Scripts/Abilities/StateMachine/State.gd"

func _update_values(input, delta):
	var movement_direction = sign(_manager.get_velocity())
	var acceleration = delta * _manager.get_acceleration()
	
	if input != 0 and sign(input) != movement_direction:
		acceleration += delta * _manager.get_acceleration()
	
	var new_velocity_magnitude_unclamped = abs(_manager.get_velocity()) - acceleration
	var new_velocity_magnitude = max(new_velocity_magnitude_unclamped, _manager.get_move_speed())
	_manager.set_velocity(movement_direction * new_velocity_magnitude)
	
func _set_state(input):
	var magnitude = abs(_manager.get_velocity())
	if magnitude <= _manager.get_move_speed():
		if input == 0:
			transition(_manager.States.IDLE)
		elif sign(input) == sign(_manager.get_velocity()):
			transition(_manager.States.MOVING)
		else:
			transition(_manager.States.TURNING)
