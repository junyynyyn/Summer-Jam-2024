extends Node

var player
var hook
var line

# For registering username to upload scores 
var username

func _ready():
	load_scores()


var level_scores = {}


func save_scores():
	var save_game = FileAccess.open("user://level_scores.json", FileAccess.WRITE)
	var json_string = JSON.stringify(level_scores)
	save_game.store_string(json_string)
	save_game.close()


func load_scores():
	if not FileAccess.file_exists("user://level_scores.json"):
		return # No save file to load
	
	var save_game = FileAccess.open("user://level_scores.json", FileAccess.READ)
	var json_string = save_game.get_as_text()
	
	# Creates the helper class to interact with JSON
	var json = JSON.new()
	
	# Parse the JSON string
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		print("JSON Parse Error: ", json.get_error_message())
		return

	level_scores = json.get_data()
	save_game.close()
	#if get_tree().get_current_scene().is_in_group("Level Select"):
		#get_tree().get_current_scene().update_progress_bars() # Update progress bars with loaded scores
		#print("Loaded scene information")


func clear_scores():
	# Clear the dictionary in memory
	level_scores.clear()

	# Update the save file
	var save_game = FileAccess.open("user://level_scores.json", FileAccess.WRITE)
	var json_string = JSON.stringify(level_scores)
	save_game.store_string(json_string)
	save_game.close()

	# Optionally, update any UI components that display these scores
	# (You may need to implement this part depending on your game's setup)
