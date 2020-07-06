extends "res://Scripts/Abilities/StateMachine/State.gd"

func _on_enter(from, input):
	_manager.get_ground_checker().connect("started_colliding", self, "_on_ground_checker_started_colliding")

func _on_exit(to, input):
	_manager.get_ground_checker().disconnect("started_colliding", self, "_on_ground_checker_started_colliding")

func _on_ground_checker_started_colliding():
	transition(_manager.States.GROUNDED)
