extends "res://Scripts/Abilities/StateMachine/StateManager.gd"

export(bool) var __debug = false

enum States {
	NONE,		# Enter state
	GROUNDED,	# On the ground.
	JUMPING,	# Jump button still held
	ASCENDING,  # Ascending with jump button released
	FALLING,	# Descending
}


var _jump
var _character_controller

func init(jump, controller):
	_jump = jump
	_character_controller = controller
	
	_jump.connect("enabled", self, "_on_enabled")
	_jump.connect("disabled", self, "_on_disabled")


func _get_enter_state():
	return States.NONE

func _initialize_states():
	state_nodes = {
		States.GROUNDED:     $Grounded,
		States.JUMPING: 	 $Jumping,
		States.ASCENDING:	 $Ascending,
		States.FALLING: 	 $Falling
	}


func get_initial_jump_force():
	return _jump.initial_jump_force

func get_hold_addition():
	return _jump.hold_addition

func get_descent_addition():
	return _jump.descent_addition

func get_ground_checker():
	return _jump.get_ground_checker()

func get_velocity():
	return _jump.get_velocity()

func set_velocity(new_velocity):
	return _jump.set_velocity(new_velocity)

func get_jump_audio():
	return _jump.get_jump_audio()

func get_sprite_controller():
	return _jump.get_sprite_controller()

func get_character_controller():
	return _character_controller


func _find_initial_state(input):
	if get_ground_checker().is_colliding:
		return States.GROUNDED
	elif get_velocity() > 0:
		return States.JUMPING
	else:
		return States.FALLING

func enable():
	_jump.enable()

func disable():
	_jump.disable()


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
