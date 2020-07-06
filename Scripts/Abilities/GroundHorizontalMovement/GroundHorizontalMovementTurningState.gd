extends "res://Scripts/Abilities/StateMachine/State.gd"

func _update_values(input, delta):
	if input == 0:
		return
	var movement_direction = sign(_manager.get_velocity())
	var acceleration = delta * _manager.get_start_acceleration()
	var new_velocity_magnitude = abs(_manager.get_velocity()) - acceleration
	_manager.set_velocity(movement_direction * new_velocity_magnitude)
	
func _set_state(input):
	if input == 0:
		transition(_manager.States.STOPPING)
	elif sign(_manager.get_velocity()) == sign(input):
		transition(_manager.States.STARTING)

func _on_enter(from, input):
	_manager.get_ground_checker().connect("stopped_colliding", self, "_on_ground_checker_stopped_colliding")
	_manager.get_sprite_controller().flip_facing()
	_manager.get_sprite_controller().play("Run")
	_manager.get_run_audio().play()

func _on_exit(to, input):
	_manager.get_ground_checker().disconnect("stopped_colliding", self, "_on_ground_checker_stopped_colliding")


func _on_disable():
	_manager.get_sprite_controller().stop()
	_manager.get_run_audio().stop()

func _on_ground_checker_stopped_colliding():
	transition(_manager.States.AIRBORNE)
