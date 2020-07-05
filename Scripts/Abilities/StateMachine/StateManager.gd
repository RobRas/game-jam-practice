extends Node

var state_nodes = { }
var _current_state

func _ready():
	set_process(false)
	_initialize_states()
	_current_state = _get_enter_state()
	for state in state_nodes.keys():
		var state_node = get_state_node(state)
		
		state_node.init(state, self)
		state_node.connect("entering", self, "_on_state_entered")
		state_node.connect("exiting", self, "_on_state_exited")

func start_machine():
	var input = _get_input()
	_current_state = _find_initial_state(input)
	var state = get_current()
	state.enter(_get_enter_state(), input)

func _process(delta):
	get_current().update(_get_input(), delta)


func set_state(new_state):
	var input = _get_input()
	
	var previous_state = _current_state
	var previous_state_node = get_state_node(previous_state)
	previous_state_node.exit(new_state, input)
	
	_current_state = new_state
	var new_state_node = get_current()
	new_state_node.enter(previous_state, input)


func get_state_node(state):
	return state_nodes[state]

func get_current():
	return state_nodes[_current_state]


func _get_input():
	pass

func _find_initial_state(input):
	pass

func _get_enter_state():
	pass

func _initialize_states():
	pass

func _on_enabled():
	start_machine()
	set_process(true)

func _on_disabled():
	if _current_state != _get_enter_state():
		var input = _get_input()
		get_current().exit(_get_enter_state(), input)
		get_current().disable()
		_current_state = _get_enter_state()
		set_process(false)


func _on_state_entered(caller, from, input):
	pass

func _on_state_exited(caller, to, input):
	pass
