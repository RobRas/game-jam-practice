extends Node2D

export(NodePath) var parent_path
var parent

export(NodePath) var character_controller_path
var character_controller

func _ready():
	parent = get_node(parent_path)
	parent.connect("enabled", self, "_on_parent_enabled")
	parent.connect("disabled", self, "_on_parent_disabled")
	
	character_controller = get_node(character_controller_path)
	
	for ability in get_children():
		if ability.has_method("init"):
			ability.init(parent, character_controller)

func add_ability(ability_node):
	add_child(ability_node)
	ability_node.init(parent, character_controller)

func remove_ability(ability_node):
	remove_child(ability_node)

func _on_parent_enabled(parent):
	for ability in get_children():
		if ability.has_method("parent_enabled"):
			ability.parent_enabled(parent)

func _on_parent_disabled(parent):
	for ability in get_children():
		if ability.has_method("parent_disabled"):
			ability.parent_disabled(parent)