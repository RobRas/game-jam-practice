extends "res://Scripts/Abilities/StateMachine/State.gd"

func _set_state(input):
	if input != 0:
		transition(_manager.States.STARTING)

func _on_enter(from, input):
	_manager.get_sprite_controller().stop()
	_manager.get_run_audio().stop()

