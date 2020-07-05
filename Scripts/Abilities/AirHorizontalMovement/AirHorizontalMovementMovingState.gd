extends "res://Scripts/Abilities/StateMachine/State.gd"
	
func _set_state(input):
	if input == 0:
		transition(_manager.States.IDLE)
	elif sign(input) != sign(_manager.get_velocity()):
		transition(_manager.States.TURNING)
