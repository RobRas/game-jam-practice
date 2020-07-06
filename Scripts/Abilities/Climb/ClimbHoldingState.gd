extends "res://Scripts/Abilities/StateMachine/State.gd"

var _has_grabbed = false

func _late_init():
	$GrabTimer.wait_time = _manager.get_grab_timer_cooldown()

func _set_state(input):
	if input != 0:
		transition(_manager.States.CLIMBING)

func _on_enter(from, input):
	_manager.get_character_controller().connect("climb_release_immediate", self, "_on_character_controller_climb_release_immediate")
	if from == _manager.States.WAITING:
		_has_grabbed = false
		$GrabTimer.start()
	else:
		_has_grabbed = true

func _on_exit(from, input):
		_manager.get_character_controller().disconnect("climb_release_immediate", self, "_on_character_controller_climb_release_immediate")

func _on_GrabTimer_timeout():
	_has_grabbed = true

func _on_character_controller_climb_release_immediate(pressed):
	if pressed:
		transition(_manager.States.COOLDOWN)
