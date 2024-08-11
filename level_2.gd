extends Node2D



func _ready():
	$AudioStreamPlayer2D.volume_db = -10.0
	$AudioStreamPlayer2D.play()
