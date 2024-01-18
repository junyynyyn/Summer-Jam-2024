extends Control

var levelselect: PackedScene = preload("res://Scenes/Menus/Level Select.tscn")
var settings: PackedScene = preload("res://Scenes/Menus/Settings.tscn")
#var settings: PackedScene = preload("settings")
var allowed_username = false
# Called when the node enters the scene tree for the first time.

func _ready():
	if Global.username == null:
		request_username()

func request_username():
	$UsernameRequest.visible = true
	$Menu.visible = false

func _on_play_pressed():
	SceneTransition.change_scene("res://Scenes/Menus/Level Select.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_settings_pressed():
	SceneTransition.change_scene("res://Scenes/Menus/Settings.tscn")


func _on_reset_pressed():
	prompt_reset_name()

func prompt_reset_name():
	$ResetConfirmation.visible = true


func _on_line_edit_text_submitted(new_text):
	var allowed_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
	var is_valid = true

	for chars in new_text:
		if chars not in allowed_chars:
			#print("Your username must only contain letters or numbers")
			$UsernameRequest/CharacterError.visible = true
			is_valid = false
			break

	if is_valid:
		Global.username = new_text
		#print(Global.username)
		$UsernameRequest.visible = false
		$Menu.visible = true
		Global.save_game_data()


func _on_scores_pressed():
	pass # Replace with function body.


func _on_scores_reset_pressed():
	var temp_username = Global.username
	var able_to_grapple: bool = false
	if Global.can_grapple:
		able_to_grapple = true
	Global.clear_game_data()
	Global.username = temp_username
	if able_to_grapple:
		Global.can_grapple = true
	#print("Username set to: " + temp_username)
	$ResetConfirmation.visible = false
	


func _on_everything_reset_pressed():
	Global.clear_game_data()
	request_username()
	$ResetConfirmation.visible = false


func _on_cancel_reset_pressed():
	$ResetConfirmation.visible = false



