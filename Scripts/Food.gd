extends Node2D


signal victory


export(Vector2) var label_movement = Vector2(0, 20)

var won = false



func _on_Area2D_body_entered(body):
	if won:
		return
	
	won = true
	
	$Control/YouWinLabel.visible = true
	var label_pos = $Control/YouWinLabel.rect_position
	var target_pos = label_pos - label_movement
	
	$LabelTween.interpolate_property($Control/YouWinLabel, "rect_position", label_pos, target_pos, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$LabelTween.start()
