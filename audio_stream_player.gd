extends AudioStreamPlayer

var level1 = preload("res://dArtagnan - Was wollen wir trinken.ogg")
var level2 = preload("res://Die Grenzwacht hielt im Osten German folk song English translation.mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _play_music(music: AudioStream, volume = -15.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
func play_level_music(level):
	if level == 1:
		_play_music(level1)
	elif level == 2:
		_play_music(level2)
	
