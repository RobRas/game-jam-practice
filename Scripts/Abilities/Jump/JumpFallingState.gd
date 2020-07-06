extends "res://Scripts/Abilities/StateMachine/State.gd"

func _update_values(input, delta):
	var fall_addition = _manager.get_descent_addition() * delta
	_manager.set_velocity(_manager.get_velocity() + fall_addition)


func _on_enter(from, input):
	_manager.get_ground_checker().connect("started_colliding", self, "_on_ground_started_colliding")

func _on_exit(to, input):
	_manager.get_ground_checker().disconnect("started_colliding", self, "_on_ground_started_colliding")


func _on_ground_started_colliding():
	transition(_manager.States.GROUNDED)
