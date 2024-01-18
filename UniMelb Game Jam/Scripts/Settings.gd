extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_home_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")


func _on_back_button_pressed():
	print("I need a back button to be implemented")
