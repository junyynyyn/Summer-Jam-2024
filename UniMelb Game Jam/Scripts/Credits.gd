extends Control


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			SceneTransition.change_scene("res://Scenes/Menus/main_menu.tscn")


func _on_texture_button_pressed():
	UiSounds.play()
	SceneTransition.change_scene("res://Scenes/Menus/main_menu.tscn") # Replace with function body.
