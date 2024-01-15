extends CanvasLayer

@export var level_select_scene : PackedScene

func _ready():
	update_ghost_count(0)

func update_ghost_count(count: int):
	%GhostCounter.text = "Ghosts Collected: " + str(count)

func update_timer(time: float):
	%Timer.text = ("Time: %.2f" % time)

func display_finish(time: float):
	%FinishScreen.visible = true
	%FinishScreen/TimeDisplay.text = "Final Time: %.2f" % time
	print("Finished Level!")

func _on_replay_button_pressed():
	get_tree().paused = false
	%FinishScreen.visible = false
	get_tree().reload_current_scene()

func _on_next_level_button_pressed():
	pass # Replace with function body.

func _on_level_select_button_pressed():
	pass # Replace with function body.
