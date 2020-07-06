extends "res://Scripts/Abilities/StateMachine/State.gd"

func _on_enter(from, input):
	_manager.get_character_controller().connect("jump_immediate", self, "_on_character_controller_jump_immediate")
	_manager.get_ground_checker().connect("stopped_colliding", self, "_on_ground_stopped_colliding")


func _on_exit(from, input):
	_manager.get_character_controller().disconnect("jump_immediate", self, "_on_character_controller_jump_immediate")
	_manager.get_ground_checker().disconnect("stopped_colliding", self, "_on_ground_stopped_colliding")

func _on_character_controller_jump_immediate(pressed):
	if pressed:
		transition(_manager.States.JUMPING)

func _on_ground_stopped_colliding():
	transition(_manager.States.DROPPING)
