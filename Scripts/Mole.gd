extends KinematicBody2D


signal clicked(mole)

export(int) var move_speed = 12000
export(int) var jump_speed = -14000
export(int) var gravity = 20000

var velocity = Vector2()

var is_grounded = false

var facing_right = true


var enabled = false

var saved_horizontal = 0.0


var has_mouse = false
	
	

func _input(event):
	if has_mouse && event.is_action_pressed("select_mole"):
		emit_signal("clicked", self)

func _physics_process(delta):
	_set_grounding()
	
	if enabled:
		_parse_horizontal_input()
		if Input.is_action_just_pressed("jump") && is_grounded:
			jump()
	
	else:
		if is_grounded:
			velocity.x = 0
	
	_apply_gravity(delta)

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
	saved_horizontal = horizontal
	
	if horizontal == 0 or not is_grounded:
		$Audio/RunAudio.stop()
	elif not $Audio/RunAudio.playing:
		$Audio/RunAudio.play()

func _apply_gravity(delta):
	if not is_grounded:
		velocity.y += gravity * delta   #times delta twice due to acceleration


func _on_Mole_mouse_entered():
	has_mouse = true


func _on_Mole_mouse_exited():
	has_mouse = false
