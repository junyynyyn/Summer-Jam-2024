extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	SceneTransition.change_scene("res://Scenes/Menus/main_menu.tscn") # Replace with function body.
