extends Node

var moles = []
var current_mole_index = 0


func _ready():
	moles = get_tree().get_nodes_in_group("Moles")
	
	for mole in moles:
		mole.get_node("Abilities/Selectable").connect("selected", self, "_on_mole_selected")
	
	set_current_mole(moles[current_mole_index])

func _process(delta):
	if Input.is_action_just_pressed("switch_mole"):
		set_current_mole(moles[(current_mole_index+1) % moles.size()])

func set_current_mole(new_mole):
	var previous_mole = moles[current_mole_index]
	previous_mole.enable(false)
	
	current_mole_index = moles.find(new_mole)
	new_mole.enable(true)

func _on_mole_selected(mole):
	if mole == moles[current_mole_index]:
		return
	set_current_mole(mole)
