extends "res://Scripts/Abilities/StateMachine/StateManager.gd"

export(bool) var __debug = false

enum States {
	NONE,		# Enter state
	IDLE,		# Standing still.
	STARTING,	# Accelerating to full speed.
	RUNNING, 	# Moving at full speed.
	STOPPING,	# Slowing to a stop (no input).
	TURNING,	# Slowing to move the other direction (input opposite velocity).
	SLOWING		# Moving faster than max speed.
}


func _get_input():
	return _controller.get_horizontal_movement()

func _get_enter_state():
	return States.NONE

func _initialize_states():
	state_nodes = {
		States.IDLE:     $Idle,
		States.STARTING: $Starting,
		States.RUNNING:  $Running,
		States.STOPPING: $Stopping,
		States.TURNING:  $Turning,
		States.SLOWING:  $Slowing
	}


func get_sprite_controller():
	return _parent.get_sprite_controller()

func get_run_audio():
	return _parent.get_run_audio()


func get_velocity():
	return _parent.get_velocity()

func set_velocity(new_velocity):
	_parent.set_velocity(new_velocity)


func get_move_speed():
	return _parent.move_speed

func get_start_acceleration():
	return _parent.start_acceleration

func get_stop_acceleration():
	return _parent.stop_acceleration


func _find_initial_state(input):
	var velocity = _parent.get_velocity()
	var magnitude = abs(velocity)
	
	if magnitude > _parent.move_speed:
		return States.SLOWING
	elif input == 0:
		if velocity == 0:
			return States.IDLE
		else:
			return States.STOPPING
	else:
		if sign(velocity) == sign(input):
			if magnitude < _parent.move_speed:
				return States.STARTING
			elif magnitude == _parent.move_speed:
				return States.RUNNING
		else:
			return States.TURNING


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
