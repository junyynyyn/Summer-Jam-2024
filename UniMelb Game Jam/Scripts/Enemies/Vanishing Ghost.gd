class_name VanishingGhost extends Ghost

@onready var light = $Sprite2D/PointLight2D

func _ready():
	super()
	ROAM_SPEED = 90.0
	ROAM_AREA = 100.0

func update_sprite_orientation():
	if velocity.x != 0:  # Check if there is horizontal movement
		sprite.flip_h = velocity.x > 0  # Flip if moving left

func _on_invisibility_duration_timeout():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(sprite, "modulate:a", 1, 1).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(light, "energy", 0.25, 1).set_trans(Tween.TRANS_LINEAR)
	
	$VisibilityDuration.start()

func _on_visibility_duration_timeout():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(sprite, "modulate:a", 0, 1).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(light, "energy", 0, 1).set_trans(Tween.TRANS_LINEAR)
	
	$InvisibilityDuration.start()
