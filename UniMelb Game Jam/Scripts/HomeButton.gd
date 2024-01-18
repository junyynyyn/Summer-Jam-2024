extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("pressed", _on_pressed)

func _on_pressed():
	SceneTransition.change_scene("res://Scenes/Menus/main_menu.tscn")
