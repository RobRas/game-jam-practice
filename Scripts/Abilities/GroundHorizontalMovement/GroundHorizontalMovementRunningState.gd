extends "res://Scripts/Abilities/StateMachine/State.gd"
	
func _set_state(input):
	if input == 0:
		transition(_manager.States.STOPPING)
	elif sign(input) != sign(_manager.get_velocity()):
		transition(_manager.States.TURNING)

func _on_enter(from, input):
	_manager.get_sprite_controller().play("Run")
	_manager.get_run_audio().play()

func _on_disable():
	_manager.get_sprite_controller().stop()
	_manager.get_run_audio().stop()
