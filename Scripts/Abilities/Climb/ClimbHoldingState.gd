extends "res://Scripts/Abilities/StateMachine/State.gd"

var _just_entered = false
var _has_grabbed = false

func _late_init():
	$GrabTimer.wait_time = _manager.get_grab_timer_cooldown()

func _set_state(input):
	_just_entered = false
	if _has_grabbed and input != 0:
		print("set")
		transition(_manager.States.CLIMBING)

func _on_enter(from, input):
	_manager.disable_abilities()
	_manager.set_velocity(0)
	_manager.get_character_controller().connect("climb_release_immediate", self, "_on_character_controller_climb_release_immediate")
	_manager.get_character_controller().connect("climb_jump_immediate", self, "_on_character_controller_climb_jump_immediate")
	if from == _manager.States.WAITING:
		_just_entered = true
		_has_grabbed = false
		$GrabTimer.start()
	else:
		_has_grabbed = true

func _on_exit(from, input):
	_manager.get_character_controller().disconnect("climb_release_immediate", self, "_on_character_controller_climb_release_immediate")
	_manager.get_character_controller().disconnect("climb_jump_immediate", self, "_on_character_controller_climb_jump_immediate")

func _on_GrabTimer_timeout():
	_has_grabbed = true

func _on_character_controller_climb_release_immediate(pressed):
	if pressed and not _just_entered:
		transition(_manager.States.COOLDOWN)

func _on_character_controller_climb_jump_immediate(pressed):
	if not pressed:
		return
	
	var horizontal = _manager.get_character_controller().get_climb_jump_horizontal_direction()
	var direction = Vector2(horizontal, -1.0).normalized()
	var jump_velocity = direction * _manager.get_wall_jump_initial_force()
	_manager.set_wall_jump_velocity(jump_velocity)
	
	_manager.get_sprite_controller().set_facing(horizontal)
	
	transition(_manager.States.COOLDOWN)
