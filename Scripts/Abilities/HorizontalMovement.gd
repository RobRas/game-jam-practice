extends Node

export(int) var move_speed = 12000
export(NodePath) var ground_checker_path
export(NodePath) var animated_sprite_path

var parent
var ground_checker
var animated_sprite

var facing_right = true

func _ready():
	ground_checker = get_node(ground_checker_path)
	animated_sprite = get_node(animated_sprite_path)

func init(parent):
	self.parent = parent

func _process(delta):
	if not parent.enabled:
		if ground_checker.is_grounded:
			parent.velocity.x = 0
		return
	
	_parse_horizontal_input()

func _parse_horizontal_input():
	var horizontal = 0
	
	if Input.is_action_pressed("move_left"):
		if facing_right:
			facing_right = false
			parent.scale.x = -parent.scale.x
		horizontal -= move_speed
	elif Input.is_action_pressed("move_right"):
		if not facing_right:
			facing_right = true
			parent.scale.x = -parent.scale.x
		horizontal += move_speed
	
	parent.velocity.x = horizontal
	
	if ground_checker.is_grounded and horizontal != 0:
		$RunAudio.play()
		animated_sprite.play("Run")
