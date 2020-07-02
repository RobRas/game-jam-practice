extends Node

var moles = []
var current_mole = null


func _ready():
	moles = get_tree().get_nodes_in_group("Moles")
	
	for mole in moles:
		mole.connect("clicked", self, "_on_mole_clicked")
	
	set_current_mole(moles[0])

func set_current_mole(mole):
	if current_mole:
		current_mole.enabled = false
	current_mole = mole
	current_mole.enabled = true

func _on_mole_clicked(mole):

	if mole == current_mole:
		return
	set_current_mole(mole)
