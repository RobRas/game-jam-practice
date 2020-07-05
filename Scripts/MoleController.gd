extends Node

const _CHARACTER_CONTROLLER = preload("res://Scripts/Controllers/CharacterController.gd")

var moles = []
var current_mole_index = 0

var camera_target


func _ready():
	camera_target = $CameraTarget
	
	moles = get_tree().get_nodes_in_group("Moles")
	
	for mole in moles:
		mole.get_node("Abilities/Selectable").connect("selected", self, "_on_mole_selected")
	
	var starting_mole = moles[current_mole_index]
	camera_target.position = starting_mole.position
	set_current_mole(starting_mole)

func _process(delta):
	if Input.is_action_just_pressed("switch_mole"):
		set_current_mole(moles[(current_mole_index+1) % moles.size()])

func set_current_mole(new_mole):
	var previous_mole = moles[current_mole_index]
	previous_mole.set_character_controller(_CHARACTER_CONTROLLER.ControllerType.UNSELECTED)
	
	current_mole_index = moles.find(new_mole)
	new_mole.set_character_controller(_CHARACTER_CONTROLLER.ControllerType.PLAYER)

	camera_target.follow_target = new_mole

func _on_mole_selected(mole):
	if mole == moles[current_mole_index]:
		return
	set_current_mole(mole)
