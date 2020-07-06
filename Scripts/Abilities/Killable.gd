extends Node

export(AudioStream) var death_audio_stream
export(float) var volume_db

func _ready():
	$DeathAudio.stream = death_audio_stream
	$DeathAudio.volume_db = volume_db

func init(parent, _controller):
	parent.connect("hazard_hit", self, "_on_hazard_hit")


func _on_hazard_hit(hazard):
	print("ow")
	$DeathAudio.play()

func enable():
	pass

func _disable():
	pass
