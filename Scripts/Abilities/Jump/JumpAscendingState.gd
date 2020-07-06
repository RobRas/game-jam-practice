extends "res://Scripts/Abilities/StateMachine/State.gd"

func _set_state(input):
	if _manager.get_velocity() >= 0:
		transition(_manager.States.FALLING)

func _on_enter(from, input):
	_manager.get_head_collision_checker().connect("started_colliding", self, "_on_head_collided")

func _on_exit(to, input):
	_manager.get_head_collision_checker().disconnect("started_colliding", self, "_on_head_collided")

func _on_head_collided():
	_manager.set_velocity(0)
	transition(_manager.States.FALLING)
