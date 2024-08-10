extends Node2D

var music = preload("res://dArtagnan - Was wollen wir trinken.ogg")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.volume_db = -10.0
	$AudioStreamPlayer.play()
