extends Control

@onready var Level1ProgBar = $GridContainer/ButtonLevel1/TextureProgressBar



func _on_back_button_pressed():
	Level1ProgBar.texture_progress=ResourceLoader.load("res://Sprites/UI/3 Golden Stars.png")
