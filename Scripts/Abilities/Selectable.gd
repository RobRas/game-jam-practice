extends Node


signal selected(parent)

var has_mouse = false
var parent

func init(parent):
	self.parent = parent
	parent.connect("mouse_entered", self, "_on_mouse_entered")
	parent.connect("mouse_exited", self, "_on_mouse_exited")

func _input(event):
	if has_mouse && event.is_action_pressed("select_mole"):
		print("i")
		emit_signal("selected", parent)


func _on_mouse_entered():
	print("Ent")
	has_mouse = true

func _on_mouse_exited():
	has_mouse = false
