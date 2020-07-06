extends "res://Scripts/Abilities/StateMachine/StateManager.gd"

enum States {
	NONE,		# Enter state
	IDLE,		# No acceleration.
	STARTING,	# Accelerating to full speed.
	MOVING, 	# Moving at full speed.
	TURNING,	# Slowing to move the other direction (input opposite velocity).
	SLOWING,	# Moving faster than max speed.
	GROUNDED	# On the ground
}

func _get_input():
	return _controller.get_horizontal_movement()

func _get_enter_state():
	return States.NONE

func _initialize_states():
	state_nodes = {
		States.IDLE:     $Idle,
		States.STARTING: $Starting,
		States.MOVING:   $Moving,
		States.TURNING:  $Turning,
		States.SLOWING:  $Slowing,
		States.GROUNDED: $Grounded
	}


func get_sprite_controller():
	return _parent.get_sprite_controller()


func get_velocity():
	return _parent.get_velocity()

func set_velocity(new_velocity):
	_parent.set_velocity(new_velocity)


func get_move_speed():
	return _parent.move_speed

func get_acceleration():
	return _parent.acceleration


func get_ground_checker():
	return _parent.get_ground_checker()


func get_initial_state():
	return _find_initial_state()


func _find_initial_state():
	if get_ground_checker().is_colliding:
		return States.GROUNDED
	
	var velocity = _parent.get_velocity()
	var magnitude = abs(velocity)
	
	var input = _get_input()
	if magnitude > _parent.move_speed:
		return States.SLOWING
	elif input == 0:
		return States.IDLE
	else:
		if sign(velocity) == sign(input):
			if magnitude < _parent.move_speed:
				return States.STARTING
			elif magnitude == _parent.move_speed:
				return States.MOVING
		else:
			return States.TURNING


func _on_state_entered(caller, from, input):
	if not __debug:
		return
	
	print("------------------------------")
	print("AirHorizontalMovement")
	print("ENTER:")
	print("From: " + str(States.keys()[from]))
	print("To: " + str(States.keys()[caller]))
	print("------------------------------")

func _on_state_exited(caller, to, input):
	if not __debug:
		return
	
	print("------------------------------")
	print("AirHorizontalMovement")
	print("EXIT:")
	print("From: " + str(States.keys()[caller]))
	print("To: " + str(States.keys()[to]))
	print("------------------------------")
