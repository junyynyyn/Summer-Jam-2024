extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("pressed", _on_pressed)

func _on_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
