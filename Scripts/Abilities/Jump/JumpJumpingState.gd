extends "res://Scripts/Abilities/StateMachine/State.gd"

func _update_values(input, delta):
	var jump_addition = -_manager.get_hold_addition() * delta
	_manager.set_velocity(_manager.get_velocity() + jump_addition)

func _set_state(input):
	if _manager.get_velocity() >= 0:
		transition(_manager.States.FALLING)

func _on_enter(from, input):
	_manager.set_velocity(-_manager.get_initial_jump_force())
	_manager.get_character_controller().connect("jump_immediate", self, "_on_character_controller_jump_immediate")
	_manager.get_head_collision_checker().connect("started_colliding", self, "_on_head_collided")
	
	_manager.get_jump_audio().play()
	_manager.get_sprite_controller().play("Jump")

func _on_exit(from, input):
		_manager.get_character_controller().disconnect("jump_immediate", self, "_on_character_controller_jump_immediate")
		_manager.get_head_collision_checker().disconnect("started_colliding", self, "_on_head_collided")

func _on_character_controller_jump_immediate(pressed):
	if not pressed:
		transition(_manager.States.ASCENDING)

func _on_head_collided():
	_manager.set_velocity(0)
	transition(_manager.States.FALLING)
