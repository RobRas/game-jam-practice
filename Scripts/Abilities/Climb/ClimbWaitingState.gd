extends "res://Scripts/Abilities/StateMachine/State.gd"

func _on_enter(from, input):
	print("Entering WAITING")
	_manager.get_character_controller().connect("climb_start_immediate", self, "_on_character_controller_grab_immediate")

func _on_exit(from, input):
	_manager.get_character_controller().disconnect("climb_start_immediate", self, "_on_character_controller_grab_immediate")

func _on_character_controller_grab_immediate(pressed):
	print("Grabbing")
	if pressed and _manager.get_collision_checker().is_colliding:
		transition(_manager.States.HOLDING)
