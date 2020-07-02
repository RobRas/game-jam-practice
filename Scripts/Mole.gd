extends KinematicBody2D

export(int) var move_speed = 12000
export(int) var jump_speed = -14000
export(int) var gravity = 20000

var velocity = Vector2()
var is_grounded = false
	
	

func _physics_process(delta):
	is_grounded = $GroundChecker.is_grounded()
	if is_grounded:
		velocity.y = 0
	
	velocity.x = 0
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= move_speed
	
	if Input.is_action_pressed("move_right"):
		velocity.x += move_speed
	
	if Input.is_action_just_pressed("jump") && is_grounded:
		jump()
	
	velocity.y += gravity * delta   #times delta twice due to acceleration

	var motion = velocity * delta
	move_and_slide(motion)

func jump():
	velocity.y = jump_speed

func hazard_hit():
	print("ow")
