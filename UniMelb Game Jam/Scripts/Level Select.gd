extends Control

@onready var Level1ProgBar = $GridContainer/ButtonLevel1/TextureProgressBar


func _ready():
	update_progress_bars()

func update_progress_bars():
	for level in Global.level_scores.keys():
		var progressBar = get_node("GridContainer/Button" + level + "/TextureProgressBar")
		progressBar.value = Global.level_scores[level]
		print(progressBar.value)


func _on_back_button_pressed():
	Level1ProgBar.texture_progress=ResourceLoader.load("res://Sprites/UI/3 Golden Stars.png")
