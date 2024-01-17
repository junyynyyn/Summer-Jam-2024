extends CanvasLayer

var level_select_screen = "res://Scenes/Menus/Level Select.tscn"
var game_paused = false
var can_pause = true

@onready var stardisplay = $"FinishScreen/Star Display"
signal next_scene

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

func display_finish(time: float):
	can_pause = false
	%FinishScreen.visible = true
	#%FinishScreen/TimeDisplay.text = "Final Time: %.2f seconds" % time
	%FinishScreen/TimeDisplay.text = "%.2f seconds" % time


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
