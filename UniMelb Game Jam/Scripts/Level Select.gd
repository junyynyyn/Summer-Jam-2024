extends Control

@onready var Level1ProgBar = $GridContainer/ButtonLevel1/TextureProgressBar
var progressBar = null

func _ready():
	update_progress_bars()


func update_progress_bars():
	for level in Global.level_scores.keys():
		if level == "TestLevel2":
			progressBar = get_node("Button" + level + "/TextureProgressBar")
		else:
			progressBar = get_node("GridContainer/Button" + level + "/TextureProgressBar")
		progressBar.value = Global.level_scores[level]
		if progressBar.value >= 4:
			progressBar.texture_progress=ResourceLoader.load("res://Sprites/UI/3 Golden Stars.png")
			
		#print(progressBar.value)


