extends Control


var levelselect: PackedScene = preload("res://Scenes/Menus/Level Select.tscn")
#var settings: PackedScene = preload("settings")

@onready var level = get_node("/root/Level")
@onready var ui = get_node("/root/Level/UI")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_continue_pressed():
	ui.unpause_game()

func _on_level_select_pressed():
	
	level.get_tree().paused = false
	get_tree().change_scene_to_packed(levelselect)


func _on_settings_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()
