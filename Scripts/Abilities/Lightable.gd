extends Node2D

export(Texture) var light_texture


func _ready():
	$Light2D.texture = light_texture
