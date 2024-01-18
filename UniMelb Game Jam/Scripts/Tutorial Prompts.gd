extends Node2D
@onready var tutorialtext = get_node("/root/Level/UI/TextureRect/Label")
@onready var tutorial = get_node("/root/Level/UI/TextureRect")


# Called when the node enters the scene tree for the first time.
func _ready():
	if not Global.can_grapple:
		tutorial.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_tutorial_2_nd_prompt_area_entered(_area):
	if not Global.can_grapple:
		if tutorial.modulate != Color(1, 1, 1, 1):
			var tween = get_tree().create_tween()
			tween.tween_property(tutorial, "modulate:a", 1, 0.2).set_trans(Tween.TRANS_LINEAR)
		tutorialtext.text = "I can't hold on to them for very long, I'll have to catch them all quickly."
	$"Tutorial Timer".start()
	


func _on_tutorial_timer_timeout():
	if not Global.can_grapple:
		var tween = get_tree().create_tween()
		tween.tween_property(tutorial, "modulate:a", 0, 0.2).set_trans(Tween.TRANS_LINEAR)



func _on_tutorial_prompt_area_entered(_area):
	pass # Replace with function body.
