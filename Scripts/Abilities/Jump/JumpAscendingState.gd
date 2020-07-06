extends "res://Scripts/Abilities/StateMachine/State.gd"

func _set_state(input):
	if _manager.get_velocity() >= 0:
		transition(_manager.States.FALLING)
