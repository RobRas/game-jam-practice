extends Node

var moles = []
var current_mole = null


func _ready():
	moles = get_tree().get_nodes_in_group("Moles")
	set_current_mole(moles[0])

func set_current_mole(mole):
	current_mole.enabled = false
	current_mole = mole
	current_mole.enabled = true
