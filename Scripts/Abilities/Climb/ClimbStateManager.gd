extends "res://Scripts/Abilities/StateMachine/StateManager.gd"

export(bool) var __debug = false

enum States {
	NONE,		# Enter state
	HOLDING,	# Standing still.
	CLIMBING,	# Moving vertically
	COOLDOWN 	# Cannot grab
}


var _climb
var _controller

func init(climb, controller):
	_climb = climb
	_controller = controller
	
	_climb.connect("enabled", self, "_on_enabled")
	_climb.connect("disabled", self, "_on_disabled")


func _get_input():
	pass

func _get_enter_state():
	return States.NONE

func _initialize_states():
	state_nodes = {
		States.WAITING:  $Waiting
		States.HOLDING:  $Holding,
		States.CLIMBING: $Climbing,
		States.COOLDOWN: $Cooldown,
	}


func get_velocity():
	return _climb.get_velocity()

func set_velocity(new_velocity):
	_climb.set_velocity(new_velocity)


func get_climb_speed():
	return _climb.climb_speed


func _find_initial_state(input):
	if input == 0:
		return States.HOLDING
	else:
		States.CLIMBING


func _on_state_entered(caller, from, input):
	if not __debug:
		return
	
	print("------------------------------")
	print("GroundHorizontalMovement")
	print("ENTER:")
	print("From: " + str(States.keys()[from]))
	print("To: " + str(States.keys()[caller]))
	print("------------------------------")

func _on_state_exited(caller, to, input):
	if not __debug:
		return
	
	print("------------------------------")
	print("GroundHorizontalMovement")
	print("EXIT:")
	print("From: " + str(States.keys()[caller]))
	print("To: " + str(States.keys()[to]))
	print("------------------------------")
