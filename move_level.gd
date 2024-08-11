extends Area2D

var first_time = true
const last_level = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func extract_number_from_string(level_string: String) -> int:
	var regex = RegEx.new()
	regex.compile("\\d+")
	var match = regex.search(level_string)
	if match:
		return match.get_string().to_int()
	return -1  # Return -1 or any default value if no number is found
	
func change_level():
	var scene_num = extract_number_from_string(get_tree().current_scene.name)
	if scene_num == last_level:
		get_tree().quit()
	else:
		get_tree().change_scene_to_file("res://level_" + str(scene_num + 1) + ".tscn")

func _on_body_entered(body):
	if first_time:
		first_time = false
	else: 
		change_level()
