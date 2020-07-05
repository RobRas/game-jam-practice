extends "res://Scripts/Abilities/StateMachine/State.gd"

func _update_values(input, delta):
	if input != 0:
		return
	
	var movement_direction = sign(_manager.get_velocity())
	var acceleration = delta * _manager.get_stop_acceleration()
	var new_velocity_magnitude_unclamped = abs(_manager.get_velocity()) - acceleration
	var new_velocity_magnitude = clamp(new_velocity_magnitude_unclamped, 0, _manager.get_move_speed())
	_manager.set_velocity(movement_direction * new_velocity_magnitude)
	
func _set_state(input):
	if input != 0:
		if sign(input) == sign(_manager.get_velocity()):
			transition(_manager.States.STARTING)
		else:
			transition(_manager.States.TURNING)
	elif _manager.get_velocity() == 0:
		transition(_manager.States.IDLE)

func _on_enter(from, input):
	_manager.get_sprite_controller().stop()
	_manager.get_run_audio().stop()
