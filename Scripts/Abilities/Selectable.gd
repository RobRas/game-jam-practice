extends Node


signal selected(parent)

var has_mouse = false
var parent

func init(parent, _controller):
	self.parent = parent
	parent.connect("mouse_entered", self, "_on_mouse_entered")
	parent.connect("mouse_exited", self, "_on_mouse_exited")

func _input(event):
	if has_mouse and event.is_action_pressed("select_mole"):
		emit_signal("selected", parent)


func _on_mouse_entered():
	has_mouse = true

func _on_mouse_exited():
	has_mouse = false

func enable():
	set_process_input(true)

func disable():
	set_process_input(false)
