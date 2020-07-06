extends "res://Scripts/Abilities/StateMachine/State.gd"


func _update_values(input, delta):
	var vertical_movement = input * _manager.get_climb_speed()
	_manager.set_velocity(vertical_movement)

func _set_state(input):
	if input == 0:
		transition(_manager.States.HOLDING)

func _on_enter(from, input):
	_manager.get_character_controller().connect("climb_release_immediate", self, "_on_character_controller_climb_release_immediate")
	_manager.get_character_controller().connect("climb_jump_immediate", self, "_on_character_controller_climb_jump_immediate")

func _on_exit(from, input):
	_manager.get_character_controller().disconnect("climb_release_immediate", self, "_on_character_controller_climb_release_immediate")
	_manager.get_character_controller().disconnect("climb_jump_immediate", self, "_on_character_controller_climb_jump_immediate")


func _on_character_controller_climb_release_immediate(pressed):
	if pressed:
		transition(_manager.States.COOLDOWN)

func _on_character_controller_climb_jump_immediate(pressed):
	if not pressed:
		return
	
	var vertical = _manager.get_vertical_input()
	var horizontal = _manager.get_character_controller().get_climb_jump_horizontal_direction()
	var direction = Vector2(horizontal, vertical).normalized()
	var jump_velocity = direction * _manager.get_wall_jump_initial_force()
	_manager.set_wall_jump_velocity(jump_velocity)
	
	_manager.get_sprite_controller().set_facing(horizontal)
	
	transition(_manager.States.COOLDOWN)
