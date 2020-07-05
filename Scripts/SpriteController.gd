extends Node2D

export(NodePath) var mole_path
var _mole

var _facing = 1

func _ready():
	_mole = get_node(mole_path)

func set_facing(direction):
	if _facing != direction:
		flip_facing()

func flip_facing():
	_facing = -_facing
	_mole.scale.x = -_mole.scale.x

func play(animation_name):
	$AnimatedSprite.play(animation_name)

func stop():
	$AnimatedSprite.stop()
