extends Node2D

export(Texture) var light_texture


func _ready():
	if light_texture:
		$Light2D.texture = light_texture

func init(parent):
	pass
