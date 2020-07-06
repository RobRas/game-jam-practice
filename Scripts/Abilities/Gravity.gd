extends Node

signal enabled
signal disabled

export(int) var gravity = 50000

export(NodePath) var ground_checker_path
var ground_checker

export(AudioStream) var land_audio_stream
export(float) var volume_db = 10

var parent = null

var _enabled = true

func _ready():
	$LandAudio.stream = land_audio_stream
	$LandAudio.volume_db = volume_db
	
	ground_checker = get_node(ground_checker_path)
	ground_checker.connect("started_colliding", self, "_on_landed")


func init(parent, _controller):
	self.parent = parent

func _physics_process(delta):
	if not _enabled:
		return
	
	if not ground_checker.is_colliding:
		parent.velocity.y += gravity * delta   #times delta twice due to acceleration

func _on_landed():
	parent.velocity.y = 0
	$LandAudio.play()


func enable():
	if not _enabled:
		_enabled = true
		print("Gravity enabled")
		emit_signal("enabled")

func disable():
	if _enabled:
		print("Gravity disabled")
		_enabled = false
		parent.velocity.y = max(0, parent.velocity.y)
		emit_signal("disabled")
