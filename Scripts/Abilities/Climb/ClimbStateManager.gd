extends "res://Scripts/Abilities/StateMachine/StateManager.gd"

export(bool) var __debug = false

enum States {
	NONE,		# Enter state
	WAITING,	# Have not grabbed yet.
	HOLDING,	# Standing still.
	CLIMBING,	# Moving vertically
	COOLDOWN 	# Cannot grab
}


func _get_input():
	return _controller.get_climb_vertical_movement()

func _get_enter_state():
	return States.NONE

func _initialize_states():
	state_nodes = {
		States.WAITING:  $Waiting,
		States.HOLDING:  $Holding,
		States.CLIMBING: $Climbing,
		States.COOLDOWN: $Cooldown,
	}

func get_grab_timer_cooldown():
	return _parent.get_grab_timer_cooldown()


func get_velocity():
	return _parent.get_velocity()

func set_velocity(new_velocity):
	_parent.set_velocity(new_velocity)


func get_parent_speed():
	return _parent.climb_speed

func get_collision_checker():
	return _parent.get_collision_checker()


func disable_abilities():
	_parent.set_disables_on_grab(true)

func enable_abilities():
	_parent.set_disables_on_grab(false)
	

func _find_initial_state(input):
	return States.WAITING


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
