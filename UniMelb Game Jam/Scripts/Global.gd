extends Node

var player
var hook
var line

# For registering username to upload scores 
var username = null

func _ready():
	load_scores()


var level_scores = {}


func save_scores():
	var save_data = {
		"level_scores": level_scores,
		"username": username
	}

	var save_game = FileAccess.open("user://level_scores.json", FileAccess.WRITE)
	var json_string = JSON.stringify(save_data)
	save_game.store_string(json_string)
	save_game.close()


func load_scores():
	if not FileAccess.file_exists("user://level_scores.json"):
		return # No save file to load

	var save_game = FileAccess.open("user://level_scores.json", FileAccess.READ)
	var json_string = save_game.get_as_text()
	var json = JSON.new()
	var parse_result = json.parse(json_string)

	if parse_result != OK:
		print("JSON Parse Error: ", json.get_error_message())
		return

	var save_data = json.get_data()
	save_game.close()

	if "level_scores" in save_data:
		level_scores = save_data["level_scores"]

	if "username" in save_data:
		username = save_data["username"]

	#if get_tree().get_current_scene().is_in_group("Level Select"):
		#get_tree().get_current_scene().update_progress_bars() # Update progress bars with loaded scores
		#print("Loaded scene information")


func clear_scores():
	# Clear the level scores and username in memory
	level_scores.clear()

	# Create a new save data structure
	var save_data = {
		"level_scores": level_scores,
		"username": username
	}

	# Update the save file
	var save_game = FileAccess.open("user://level_scores.json", FileAccess.WRITE)
	var json_string = JSON.stringify(save_data)
	save_game.store_string(json_string)
	save_game.close()

	# Optionally, update any UI components that display these scores or username
	# (You may need to implement this part depending on your game's setup)

