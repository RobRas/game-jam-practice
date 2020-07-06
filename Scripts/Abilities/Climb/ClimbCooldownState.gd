extends "res://Scripts/Abilities/StateMachine/State.gd"

func _late_init():
	$CooldownDurationTimer.wait_time = _manager.get_pre_climb_cooldown()

func _on_enter(from, input):
	_manager.enable_abilities()
	$CooldownDurationTimer.start()

func _on_CooldownDurationTimer_timeout():
	transition(_manager.States.WAITING)
