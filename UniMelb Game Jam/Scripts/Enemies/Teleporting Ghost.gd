extends Ghost

@export var teleport_point_1 : Marker2D
@export var teleport_point_2 : Marker2D

var teleport_cooldown = false

func _on_detection_area_body_entered(_body):
	if (not teleport_cooldown):
		grappleable = false
		teleport_cooldown = true
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		#tween.bind_node(self)
		tween.tween_property(sprite, "modulate:a", 0, 0.2).set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(light, "energy", 0, 0.2).set_trans(Tween.TRANS_LINEAR)
		
		await tween.finished
		tween.kill()
		var distance_point_1 = position.distance_to(teleport_point_1.position)
		var distance_point_2 = position.distance_to(teleport_point_2.position)
		
		if (distance_point_1 > distance_point_2):
			teleport(teleport_point_1)
		else:
			teleport(teleport_point_2)
		grappleable = true
		
		tween = get_tree().create_tween()
		tween.set_parallel(true)
		#tween.bind_node(self)
		tween.tween_property(sprite, "modulate:a", 1, 0.2).set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(light, "energy", 0.25, 0.2).set_trans(Tween.TRANS_LINEAR)
		
		$CooldownTimer.start()

func teleport(point: Marker2D):
	position = point.position

func _on_cooldown_timer_timeout():
	teleport_cooldown = false
