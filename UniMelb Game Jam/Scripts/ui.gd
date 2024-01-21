extends CanvasLayer

var level_select_screen = "res://Scenes/Menus/Level Select.tscn"
var game_paused = false
var can_pause = true

@onready var stardisplay = $"FinishScreen/Star Display"
signal next_scene
signal scores_submitted

func _ready():
	%FinishScreen.visible = false
	%"FinishScreen/Star Display/StarParticles".emitting = false
	update_ghost_count(0)

func set_ghost_count_max(count: int):
	%GhostCounter.max_value = count
	
func update_ghost_count(count: int):
	%GhostCounter.value = count

func update_timer(time: float):
	%Timer.text = ("%.2f" % time)

func display_finish(time: float, current_level_name: String, new_best: bool):
	can_pause = false
	$FinishScreen.visible = true
	$FinishScreen/TimeDisplay.text = "%.2f seconds" % time

	var best_time = Global.level_times.get(current_level_name)
	var best_time_msg = "Best time: --"
	if best_time != null:
		best_time_msg = "Best time: %.2f seconds" % best_time

	if new_best:
		best_time_msg = "New best!: %.2f seconds" % time

	$"FinishScreen/Best Time".text = best_time_msg


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			if game_paused == true:
				unpause_game()
				game_paused = false
				
			elif game_paused == false:
				pause_game()
				game_paused = true
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_R:
			get_tree().paused = false
			%FinishScreen.visible = false
			get_tree().reload_current_scene()

func pause_game():
	if can_pause == true:
		get_tree().paused = true
		$"Pause Menu".visible = true

func unpause_game():
	if can_pause == true:
		get_tree().paused = false
		$"Pause Menu".visible = false

func _on_replay_button_pressed():
	get_tree().paused = false
	%FinishScreen.visible = false
	get_tree().reload_current_scene()

func _on_next_level_button_pressed():
	get_tree().paused = false
	%FinishScreen.visible = false
	emit_signal("next_scene")

func _on_level_select_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(level_select_screen)

func reward_stars(stars):
	stardisplay.value = stars
	if stars >= 4:
		stardisplay.texture_progress=ResourceLoader.load("res://Sprites/UI/3 Golden Stars.png")
		$"FinishScreen/Star Display/StarParticles".emitting = true
	#print(stars)

func send_scores(level_number, username, time):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	var url = "https://phantomsnatcher.zematoxic.dev/level/" + level_number
	var data = {"username": username, "time": time}
	var json = JSON.stringify(data)
	var headers = ["Content-Type: application/json"]
	http_request.request(url, headers, HTTPClient.METHOD_POST, json)
	await http_request.request_completed
	check_scores(level_number)

func check_scores(level_number):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)

	var error = http_request.request(("https://phantomsnatcher.zematoxic.dev/level/") + level_number)
	if error != OK:
		push_error("An error occurred in the HTTP request.")


@onready var leaderboard_names_container = get_node("/root/Level/UI/FinishScreen/Leaderboard/HBoxContainer/Usernames")
@onready var leaderboard_times_container = get_node("/root/Level/UI/FinishScreen/Leaderboard/HBoxContainer/Times")


func _http_request_completed(_result, _response_code, _headers, body):
	var json = JSON.new()
	var body_string = body.get_string_from_utf8()
	var _json_result = json.parse(body_string)
	var _json_result2 = json.parse(json.data)
	var data = json.data
	
	#Clear any existing debug entries in the leaderboard
	for children in leaderboard_names_container.get_children():
		children.queue_free()
	for children in leaderboard_times_container.get_children():
		children.queue_free()
	
	#Sort function
	data.sort_custom(sort_entries)
	
	for entry in data:
		var username = entry["username"]
		var time = entry["time"]
		var leaderboard_names = Label.new()
		var leaderboard_times = Label.new()
		leaderboard_names.text = "%s" % username
		leaderboard_times.text = "%.2f seconds" % time
		
		leaderboard_names.clip_text = true
		leaderboard_times.clip_text = true
		
		leaderboard_names.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
		leaderboard_times.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
		
		leaderboard_names_container.add_child(leaderboard_names)
		leaderboard_times_container.add_child(leaderboard_times)

func sort_entries(a, b):
	if a["time"] < b["time"]:
		return true
	return false
