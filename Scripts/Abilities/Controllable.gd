extends Node

signal controlled(parent)
signal uncontrolled(parent)

var tween

var controlled = false


func _ready():
	tween = $SelectionTween

func init(parent):
	parent.connect("enabled", self, "_on_enabled")
	parent.connect("disabled", self, "_on_disabled")

func _on_enabled(mole):
	if controlled:
		return

	controlled = true
	
	emit_signal("controlled", mole)

	var scale_size = 1.1
	tween.interpolate_property(mole.get_node("SpriteScaling"), "scale", Vector2(1, 1), Vector2(scale_size, scale_size), 0.08, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property(mole.get_node("SpriteScaling"), "scale", Vector2(scale_size, scale_size), Vector2(1, 1), 0.08, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_disabled(mole):
	print("pre")
	if not controlled:
		return
	
	controlled = false
	emit_signal("uncontrolled", mole)
	print("post")
