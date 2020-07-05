extends "res://Scripts/Abilities/GroundHorizontalMovementStates/GroundHorizontalMovementState.gd"

func _update_values(input, delta):
	if input == 0:
		return
	
	var acceleration = delta * _manager.get_start_acceleration()
	var new_velocity_magnitude_unclamped = abs(_manager.get_velocity()) + acceleration
	var new_velocity_magnitude = clamp(new_velocity_magnitude_unclamped, 0, _manager.get_move_speed())
	_manager.set_velocity(input * new_velocity_magnitude)
	
func _set_state(input):
	if input == 0:
		transition(_manager.States.STOPPING)
	elif sign(input) != sign(_manager.get_velocity()):
		transition(_manager.States.TURNING)
	elif abs(_manager.get_velocity()) == _manager.get_move_speed():
		transition(_manager.States.RUNNING)

func _on_enter(from, input):
	_manager.get_sprite_controller().set_facing(input)
	_manager.get_sprite_controller().play("Run")
	_manager.get_run_audio().play()

func _on_disable():
	_manager.get_sprite_controller().stop()
	_manager.get_run_audio().stop()
