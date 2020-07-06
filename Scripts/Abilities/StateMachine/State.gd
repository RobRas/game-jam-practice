extends Node

signal entering(caller, from, input)
signal exiting(caller, to, input)
signal disabled

var _state
var _manager

func init(state, manager):
	_state = state
	_manager = manager
	_late_init()

func update(input, delta):
	_update_values(input, delta)
	_set_state(input)

func _late_init():
	pass

func _update_values(input, delta):
	pass

func _set_state(input):
	pass

func transition(new_state):
	_manager.set_state(new_state)

func enter(from, input):
	_on_enter(from, input)
	emit_signal("entering", _state, from, input)

func exit(to, input):
	_on_exit(to, input)
	emit_signal("exiting", _state, to, input)

func disable():
	_on_disable()
	emit_signal("disabled")

func _on_enter(from, input):
	pass

func _on_exit(to, input):
	pass

func _on_disable():
	pass
