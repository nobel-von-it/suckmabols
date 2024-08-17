extends Node2D

const path = "res://dArtagnan - Was wollen wir trinken.ogg"
var music = preload(path)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play_level_music(1)

func _on_player_died():
	get_tree().change_scene_to_file("res://restart_bar.tscn")
