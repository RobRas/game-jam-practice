extends "res://Scripts/Abilities/StateMachine/State.gd"


func _update_values(input, delta):
	var vertical_movement = input * delta
	_manager.set_velocity(vertical_movement)

func _set_state(input):
	if input == 0:
		transition(_manager.States.HOLDING)

func _on_enter(from, input):
	_manager.get_character_controller().connect("climb_release_immediate", self, "_on_character_controller_climb_release_immediate")

func _on_exit(from, input):
		_manager.get_character_controller().disconnect("climb_release_immediate", self, "_on_character_controller_climb_release_immediate")


func _on_character_controller_climb_release_immediate(pressed):
	if pressed:
		transition(_manager.States.COOLDOWN)
