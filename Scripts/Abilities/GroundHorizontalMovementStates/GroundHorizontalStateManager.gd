extends Node

enum States {
	NONE,		# Enter state
	IDLE,		# Standing still.
	STARTING,	# Accelerating to full speed.
	RUNNING, 	# Moving at full speed.
	STOPPING,	# Slowing to a stop (no input).
	TURNING,	# Slowing to move the other direction (input opposite velocity).
	SLOWING		# Moving faster than max speed.
}

onready var state_nodes = {
	States.IDLE:     $Idle,
	States.STARTING: $Starting,
	States.RUNNING:  $Running,
	States.STOPPING: $Stopping,
	States.TURNING:  $Turning,
	States.SLOWING:  $Slowing
}

var _current_state

var _movement
var _controller

func _ready():
	for state in state_nodes.keys():
		var state_node = get_state_node(state)
		
		state_node.init(state, self)
		state_node.connect("entering", self, "_on_state_entered")
		state_node.connect("exiting", self, "_on_state_exited")

func init(movement, controller):
	_movement = movement
	_controller = controller
	
	_movement.connect("enabled", self, "_on_enabled")
	_movement.connect("disabled", self, "_on_disabled")
	
	var input = _controller.get_horizontal_movement()
	_current_state = _find_initial_state(input)
	var state = get_state_node(_current_state)
	state.enter(States.NONE, input)

func _process(delta):
	get_state_node(_current_state).update(_controller.get_horizontal_movement(), delta)


func set_state(new_state):
	var input = _controller.get_horizontal_movement()
	
	var previous_state = _current_state
	var previous_state_node = get_state_node(previous_state)
	previous_state_node.exit(new_state, input)
	
	_current_state = new_state
	var new_state_node = get_state_node(_current_state)
	new_state_node.enter(previous_state, input)

func get_state_node(state):
	return state_nodes[state]


func get_sprite_controller():
	return _movement.get_sprite_controller()

func get_run_audio():
	return _movement.get_run_audio()


func get_velocity():
	return _movement.get_velocity()

func set_velocity(new_velocity):
	_movement.set_velocity(new_velocity)


func get_move_speed():
	return _movement.move_speed

func get_start_acceleration():
	return _movement.start_acceleration

func get_stop_acceleration():
	return _movement.stop_acceleration


func _find_initial_state(input):
	var velocity = _movement.get_velocity()
	var magnitude = abs(velocity)
	
	if magnitude > _movement.move_speed:
		return States.SLOWING
	elif input == 0:
		if velocity == 0:
			return States.IDLE
		else:
			return States.STOPPING
	else:
		if sign(velocity) == sign(input):
			if magnitude < _movement.move_speed:
				return States.STARTING
			elif magnitude == _movement.move_speed:
				return States.RUNNING
		else:
			return States.TURNING


func _on_enabled():
	var input = _controller.get_horizontal_movement()
	_current_state = _find_initial_state(input)
	get_state_node(_current_state).enter(States.NONE, input)
	set_process(true)

func _on_disabled():
	if _current_state != States.NONE:
		var input = _controller.get_horizontal_movement()
		get_state_node(_current_state).exit(States.NONE, input)
		get_state_node(_current_state).disable()
		_current_state = States.NONE
		set_process(false)


func _on_state_entered(caller, from, input):
	print("------------------------------")
	print("ENTER:")
	print("From: " + str(States.keys()[from]))
	print("To: " + str(States.keys()[caller]))
	print("------------------------------")

func _on_state_exited(caller, to, input):
	print("------------------------------")
	print("EXIT:")
	print("From: " + str(States.keys()[caller]))
	print("To: " + str(States.keys()[to]))
	print("------------------------------")
