extends CanvasLayer

var level_select_screen = "res://Scenes/Menus/Level Select.tscn"

signal next_scene

func _ready():
	update_ghost_count(0)

func set_ghost_count_max(count: int):
	%GhostCounter.max_value = count
	
func update_ghost_count(count: int):
	%GhostCounter.value = count

func update_timer(time: float):
	%Timer.text = ("%.2f" % time)

func display_finish(time: float):
	%FinishScreen.visible = true
	#%FinishScreen/TimeDisplay.text = "Final Time: %.2f seconds" % time
	%FinishScreen/TimeDisplay.text = "%.2f seconds" % time

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
