extends Node


signal selected(parent)

var has_mouse = false
var parent

var controlled = false

func init(parent):
	self.parent = parent
	parent.connect("mouse_entered", self, "_on_mouse_entered")
	parent.connect("mouse_exited", self, "_on_mouse_exited")

func _input(event):
	if has_mouse and event.is_action_pressed("select_mole") and not controlled:
		emit_signal("selected", parent)


func _on_mouse_entered():
	has_mouse = true

func _on_mouse_exited():
	has_mouse = false

func _on_control_enabled(_mole):
	controlled = true

func _on_control_disabled(_mole):
	controlled = false
