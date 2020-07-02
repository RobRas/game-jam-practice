extends KinematicBody2D

export(int) var move_speed = 12000
export(int) var jump_speed = -14000
export(int) var gravity = 20000

var velocity = Vector2()

var is_grounded = false

var facing_right = true


var enabled = false
	
	

func _physics_process(delta):
	_set_grounding()
	_parse_horizontal_input()
	
	if Input.is_action_just_pressed("jump") && is_grounded:
		jump()
	
	velocity.y += gravity * delta   #times delta twice due to acceleration

	var motion = velocity * delta
	move_and_slide(motion)

func jump():
	velocity.y = jump_speed
	$Audio/JumpAudio.play()

func hazard_hit():
	print("ow")
	$Audio/DeathAudio.play()

func _set_grounding():
	var was_grounded = is_grounded
	is_grounded = $GroundChecker.is_grounded()
	if is_grounded:
		velocity.y = 0
		if not was_grounded:
			$Audio/LandAudio.play()

func _parse_horizontal_input():
	var horizontal = 0
	
	if Input.is_action_pressed("move_left"):
		if facing_right:
			facing_right = false
			scale.x = -scale.x
		horizontal -= move_speed
	elif Input.is_action_pressed("move_right"):
		if not facing_right:
			facing_right = true
			scale.x = -scale.x
		horizontal += move_speed
	
	velocity.x = horizontal
	
	if horizontal == 0 or not is_grounded:
		$Audio/RunAudio.stop()
	elif not $Audio/RunAudio.playing:
		$Audio/RunAudio.play()
