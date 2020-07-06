extends "res://Scripts/Abilities/StateMachine/State.gd"

func _update_values(input, delta):
	if input == 0:
		return
	var movement_direction = sign(_manager.get_velocity())
	var acceleration = delta * _manager.get_acceleration()
	var new_velocity_magnitude = abs(_manager.get_velocity()) - acceleration
	_manager.set_velocity(movement_direction * new_velocity_magnitude)
	
func _set_state(input):
	if input == 0:
		transition(_manager.States.IDLE)
	elif sign(_manager.get_velocity()) == sign(input):
		transition(_manager.States.STARTING)

func _on_enter(from, input):
	_manager.get_sprite_controller().set_facing(input)
	_manager.get_ground_checker().connect("started_colliding", self, "_on_ground_checker_started_colliding")

func _on_exit(to, input):
	_manager.get_ground_checker().disconnect("started_colliding", self, "_on_ground_checker_started_colliding")

func _on_ground_checker_started_colliding():
	transition(_manager.States.GROUNDED)
