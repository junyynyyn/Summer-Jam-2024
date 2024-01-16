extends TextureButton

@export var level_scene : String
var base_level_string = "res://Scenes/Levels/"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("pressed", _on_pressed)

func _on_pressed():
	if (level_scene):
		get_tree().change_scene_to_file(base_level_string + level_scene + ".tscn")
