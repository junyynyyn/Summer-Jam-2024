class_name VanishingGhost extends Ghost

@export var MAX_SPEED : float = 150.0
@export var ROAM_SPEED : float = 90
var speed : float = 20.0
var roam_target : Vector2 = Vector2(0,0)

@onready var sprite = $Sprite2D
@onready var light = $Sprite2D/PointLight2D

func _process(_delta):
	if ghost_state == state.ROAMING:
		var direction = (roam_target - position).normalized()
		#print("Roam Target: ", roam_target, ", Direction: ", direction)  # Debugging print
		speed = lerp(speed, ROAM_SPEED, 0.5)
		velocity = direction * speed * speed_multiplier
	elif ghost_state == state.RUNNING:
		var direction = (roam_target - position).normalized()
		#print("Roam Target: ", roam_target, ", Direction: ", direction)  # Debugging print
		speed = lerp(speed, ROAM_SPEED, 0.5)
		velocity = direction * speed * speed_multiplier

	update_sprite_orientation()
	move_and_slide()

func update_sprite_orientation():
	if velocity.x != 0:  # Check if there is horizontal movement
		sprite.flip_h = velocity.x > 0  # Flip if moving left

func _on_roam_timer_timeout():
	speed = ROAM_SPEED
	var rng = RandomNumberGenerator.new()
	roam_target.x = position.x + rng.randf_range(-100.0, 100.0)
	roam_target.y = position.y + rng.randf_range(-100.0, 100.0)
	#print("New Roam Target: ", roam_target)  # Debugging print
	




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
