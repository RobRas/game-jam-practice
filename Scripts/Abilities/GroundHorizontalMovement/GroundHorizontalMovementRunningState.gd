extends "res://Scripts/Abilities/StateMachine/State.gd"
	
func _set_state(input):
	if input == 0:
		transition(_manager.States.STOPPING)
	elif sign(input) != sign(_manager.get_velocity()):
		transition(_manager.States.TURNING)

func _on_enter(from, input):
	_manager.get_ground_checker().connect("stopped_colliding", self, "_on_ground_checker_stopped_colliding")
	_manager.get_sprite_controller().play("Run")
	_manager.get_run_audio().play()

func _on_exit(to, input):
	_manager.get_ground_checker().disconnect("stopped_colliding", self, "_on_ground_checker_stopped_colliding")


func _on_disable():
	_manager.get_sprite_controller().stop()
	_manager.get_run_audio().stop()

func _on_ground_checker_stopped_colliding():
	transition(_manager.States.AIRBORNE)
