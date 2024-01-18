extends Node

var player
var hook
var line
var can_grapple = false
# For registering username to upload scores 
var username = null

func _ready():
	load_game_data()


var level_times = {}
var level_stars = {}  # New dictionary for star ratings

func save_game_data():
	var save_data = {
		"level_times": level_times,
		"level_stars": level_stars,  # Include star ratings
		"username": username
	}

	var save_game = FileAccess.open("user://game_data.json", FileAccess.WRITE)
	var json_string = JSON.stringify(save_data)
	save_game.store_string(json_string)
	save_game.close()


func load_game_data():
	if not FileAccess.file_exists("user://game_data.json"):
		return # No save file to load

	var save_game = FileAccess.open("user://game_data.json", FileAccess.READ)
	var json_string = save_game.get_as_text()
	var json = JSON.new()
	var parse_result = json.parse(json_string)

	if parse_result != OK:
		print("JSON Parse Error: ", json.get_error_message())
		return

	var save_data = json.get_data()
	save_game.close()

	if "level_times" in save_data:
		level_times = save_data["level_times"]
	if "level_stars" in save_data:
		level_stars = save_data["level_stars"]
	if "username" in save_data:
		username = save_data["username"]



func clear_game_data():
	level_times.clear()
	level_stars.clear()
	username = null

	var save_data = {
		"level_times": level_times,
		"level_stars": level_stars,
		"username": username
	}

	var save_game = FileAccess.open("user://game_data.json", FileAccess.WRITE)
	var json_string = JSON.stringify(save_data)
	save_game.store_string(json_string)
	save_game.close()

	# Optionally, update any UI components that display these scores or username
	# (You may need to implement this part depending on your game's setup)

