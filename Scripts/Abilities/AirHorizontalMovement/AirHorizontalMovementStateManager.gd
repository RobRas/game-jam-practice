extends "res://Scripts/Abilities/StateMachine/StateManager.gd"

export(bool) var __debug = false

enum States {
	NONE,		# Enter state
	IDLE,		# No acceleration.
	STARTING,	# Accelerating to full speed.
	MOVING, 	# Moving at full speed.
	TURNING,	# Slowing to move the other direction (input opposite velocity).
	SLOWING		# Moving faster than max speed.
}


var _movement
var _controller

func init(movement, controller):
	_movement = movement
	_controller = controller
	
	_movement.connect("enabled", self, "_on_enabled")
	_movement.connect("disabled", self, "_on_disabled")


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
		States.SLOWING:  $Slowing
	}


func get_sprite_controller():
	return _movement.get_sprite_controller()


func get_velocity():
	return _movement.get_velocity()

func set_velocity(new_velocity):
	_movement.set_velocity(new_velocity)


func get_move_speed():
	return _movement.move_speed

func get_acceleration():
	return _movement.acceleration


func _find_initial_state(input):
	var velocity = _movement.get_velocity()
	var magnitude = abs(velocity)
	
	if magnitude > _movement.move_speed:
		return States.SLOWING
	elif input == 0:
		return States.IDLE
	else:
		if sign(velocity) == sign(input):
			if magnitude < _movement.move_speed:
				return States.STARTING
			elif magnitude == _movement.move_speed:
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
