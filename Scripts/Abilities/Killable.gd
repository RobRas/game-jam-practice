extends Node

export(AudioStream) var death_audio_stream

func init(parent):
	parent.connect("hazard_hit", self, "_on_hazard_hit")
	if death_audio_stream:
		$DeathAudio.stream = death_audio_stream


func _on_hazard_hit(hazard):
	print("ow")
	$DeathAudio.play()
