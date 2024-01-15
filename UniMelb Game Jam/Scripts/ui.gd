extends CanvasLayer

@export var level_select_scene : PackedScene

signal next_scene

func _ready():
	update_ghost_count(0)

func update_ghost_count(count: int):
	%GhostCounter.value += count
	# Doesnt work, needs to increase by one for each ghost collected and update when they're released

func update_timer(time: float):
	%Timer.text = ("%.2f" % time)

func display_finish(time: float):
	%FinishScreen.visible = true
	%FinishScreen/TimeDisplay.text = "Final Time: %.2f seconds" % time
	print("Finished Level!")

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
	get_tree().change_scene_to_packed(level_select_scene)
