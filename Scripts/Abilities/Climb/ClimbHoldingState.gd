extends "res://Scripts/Abilities/StateMachine/State.gd"

func _on_enter(from, input):
	_manager.get_character_controller().connect("climb_immediate", self, "_on_character_controller_climb_immediate")

func _on_exit(from, input):
	_manager.get_character_controller().disconnect("climb_immediate", self, "_on_character_controller_climb_immediate")

func _on_character_controller_climb_immediate(pressed):
	if pressed:
		transition(_manager.States.Climbing)
