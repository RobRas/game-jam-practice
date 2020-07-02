extends Node

export(int) var gravity = 20000
export(NodePath) var ground_checker_path

export(AudioStream) var land_audio_stream

var parent = null
var ground_checker


func _ready():
	ground_checker = get_node(ground_checker_path)
	ground_checker.connect("landed", self, "_on_landed")
	
	if land_audio_stream:
		$LandAudio.stream = land_audio_stream

func init(parent):
	self.parent = parent

func _physics_process(delta):
	if not ground_checker.is_grounded:
		parent.velocity.y += gravity * delta   #times delta twice due to acceleration

func _on_landed():
	parent.velocity.y = 0
	$LandAudio.play()
