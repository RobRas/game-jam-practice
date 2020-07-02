extends Node

export(int) var jump_speed = -14000
export(NodePath) var ground_checker_path

var parent = null
var ground_checker


func _ready():
	ground_checker = get_node(ground_checker_path)

func init(parent):
	self.parent = parent

func _process(delta):
	if not parent.enabled:
		return
	
	if Input.is_action_just_pressed("jump") and ground_checker.is_grounded:
		jump()

func jump():
	parent.velocity.y = jump_speed
	$JumpAudio.play()
