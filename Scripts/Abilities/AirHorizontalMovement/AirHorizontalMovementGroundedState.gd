extends "res://Scripts/Abilities/StateMachine/State.gd"

func _on_enter(from, input):
	_manager.get_ground_checker().connect("stopped_colliding", self, "_on_ground_checker_stopped_colliding")

func _on_exit(to, input):
	_manager.get_ground_checker().disconnect("stopped_colliding", self, "_on_ground_checker_stopped_colliding")

func _on_ground_checker_stopped_colliding():
	transition(_manager.get_initial_state())
