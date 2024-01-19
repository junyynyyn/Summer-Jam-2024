class_name Turning_Ghost extends Ghost

var run_direction : Vector2 = Vector2(0,0)

func run():
	$AnimationPlayer.play("Run")
	velocity = run_direction * RUN_SPEED * speed_multiplier

func roam():
	direction = (position - roam_target).normalized()
	speed = lerp(speed, ROAM_SPEED, 0.5)
	velocity = direction * speed * speed_multiplier
	$AnimationPlayer.play("Idle")

func _on_detection_area_body_entered(body):
	ghost_state = state.RUNNING
	# Get player direction in relation to ghost, normalize and rotate by 90 degrees
	if (body.is_in_group("Player")):
		run_direction = -(Global.player.global_position - position).normalized()
		run_direction = run_direction.rotated(PI/2)

func _on_detection_area_body_exited(_body):
	$RunningTimer.start()

func _on_running_timer_timeout():
	ghost_state = state.ROAMING
	velocity = Vector2(0,0)
	
