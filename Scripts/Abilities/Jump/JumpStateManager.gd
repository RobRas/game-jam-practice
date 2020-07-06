extends "res://Scripts/Abilities/StateMachine/StateManager.gd"

enum States {
	NONE,		# Enter state
	GROUNDED,	# On the ground.
	JUMPING,	# Jump button still held
	ASCENDING,  # Ascending with jump button released
	FALLING,	# Descending
	DROPPING	# Falling without jumping first
}


func _get_enter_state():
	return States.NONE

func _initialize_states():
	state_nodes = {
		States.GROUNDED:     $Grounded,
		States.JUMPING: 	 $Jumping,
		States.ASCENDING:	 $Ascending,
		States.FALLING: 	 $Falling,
		States.DROPPING:	 $Dropping
	}


func get_initial_jump_force():
	return _parent.initial_jump_force

func get_hold_addition():
	return _parent.hold_addition

func get_descent_addition():
	return _parent.descent_addition

func get_ground_checker():
	return _parent.get_ground_checker()

func get_velocity():
	return _parent.get_velocity()

func set_velocity(new_velocity):
	return _parent.set_velocity(new_velocity)

func get_jump_audio():
	return _parent.get_jump_audio()

func get_sprite_controller():
	return _parent.get_sprite_controller()

func get_character_controller():
	return _controller

func get_head_collision_checker():
	return _parent.get_head_collision_checker()


func _find_initial_state():
	if get_ground_checker().is_colliding:
		return States.GROUNDED
	else:
		return States.DROPPING

func enable():
	_parent.enable()

func disable():
	_parent.disable()


func _on_state_entered(caller, from, input):
	if not __debug:
		return
	
	print("------------------------------")
	print("Jump")
	print("ENTER:")
	print("From: " + str(States.keys()[from]))
	print("To: " + str(States.keys()[caller]))
	print("------------------------------")

func _on_state_exited(caller, to, input):
	if not __debug:
		return
	
	print("------------------------------")
	print("Jump")
	print("EXIT:")
	print("From: " + str(States.keys()[caller]))
	print("To: " + str(States.keys()[to]))
	print("------------------------------")
