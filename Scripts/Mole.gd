extends KinematicBody2D

export(int) var move_speed = 1200
export(int) var jump_speed = -140
export(int) var gravity = 800

var velocity = Vector2()
var is_grounded = false


func _input(event):
	var horizontal: int = 0
	
	if event.is_action("move_left"):
		horizontal -= move_speed
	
	if event.is_action("move_right"):
		horizontal += move_speed
	
	velocity.x = horizontal
	
	if event.is_action_pressed("jump") && is_grounded:
		jump()
	
	
	

func _physics_process(delta):
	is_grounded = $GroundChecker.is_colliding()
	
	velocity.y += gravity * delta   #times delta twice due to acceleration

	var motion = velocity * delta
	move_and_slide(motion)

func jump():
	velocity.y = jump_speed
