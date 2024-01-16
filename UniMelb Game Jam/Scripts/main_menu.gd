extends Control

var levelselect: PackedScene = preload("res://Scenes/Menus/Level Select.tscn")
#var settings: PackedScene = preload("settings")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_play_pressed():
	get_tree().change_scene_to_packed(levelselect)

func _on_quit_pressed():
	get_tree().quit()
