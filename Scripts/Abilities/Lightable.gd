extends Node2D

export(Texture) var light_texture
var LightTween 
var LightTween2
var direction ="down"


func _ready():
	if light_texture:
		$Light2D.texture = light_texture
		LightTween = $Light2D/LightTweenDown
		_light_glow(direction)

func init(parent):
	pass
	
func _light_glow(direction):
	if direction =="down":
		LightTween.interpolate_property($Light2D,"energy",1,.5,5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		LightTween.start()
		yield(LightTween, "tween_completed")
		direction="up"
	else:
		LightTween.interpolate_property($Light2D,"energy",.5,1,5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		LightTween.start()
		yield(LightTween, "tween_completed")
		direction="down"
	_on_light_glow_complete()

func _on_light_glow_complete():
	if direction=="down":
		_light_glow(direction)
		direction="up"
	else:
		_light_glow(direction)
		direction="down"
	
