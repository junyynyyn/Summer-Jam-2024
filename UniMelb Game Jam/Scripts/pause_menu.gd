extends Control

var levelselect: PackedScene = preload("res://Scenes/Menus/Level Select.tscn")
var settings: PackedScene = preload("res://Scenes/Menus/Settings.tscn")

@onready var level = get_node("/root/Level")
@onready var ui = get_node("/root/Level/UI")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_continue_pressed():
	UiSounds.play()
	ui.unpause_game()

func _on_level_select_pressed():
	level.get_tree().paused = false
	UiSounds.play()
	SceneTransition.change_scene("res://Scenes/Menus/Level Select.tscn")


func _on_quit_pressed():
	UiSounds.play()
	get_tree().quit()


func _on_restart_pressed():
	UiSounds.play()
	get_tree().paused = false
	%FinishScreen.visible = false
	get_tree().reload_current_scene()


func _on_home_pressed():
	UiSounds.play()
	SceneTransition.change_scene("res://Scenes/Menus/main_menu.tscn")
