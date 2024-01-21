extends Control

@onready var master_slider = $Master
@onready var music_slider = $Music
@onready var sfx_slider = $"Sound Effects"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.load_game_data()
	update_volume_sliders()

func update_volume_sliders():
	master_slider.value = Global.master_volume
	music_slider.value = Global.music_volume
	sfx_slider.value = Global.sfx_volume

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_home_pressed():
	UiSounds.play()
	SceneTransition.change_scene("res://Scenes/Menus/main_menu.tscn")



func _on_master_value_changed(value: float) -> void:
	# Set the master volume in the audio server and save the setting
	Global.master_volume = value
	Global.save_game_data()


func _on_music_changed(value: float) -> void:
	Global.music_volume = value
	Global.save_game_data()


func _on_sound_effects_changed(value: float) -> void:
	UiSounds.play()
	Global.sfx_volume = value
	Global.save_game_data()
