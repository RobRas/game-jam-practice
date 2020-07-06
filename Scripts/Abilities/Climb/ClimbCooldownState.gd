extends "res://Scripts/Abilities/StateMachine/State.gd"

func _on_enter(from, input):
	$CooldownDurationTimer.start()

func _on_CooldownDurationTimer_timeout():
	transition(_manager.States.WAITING)
