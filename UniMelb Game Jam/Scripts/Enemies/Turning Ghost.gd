class_name Turning_Ghost extends Ghost

var run_direction : Vector2 = Vector2(0,0)

func run():
	velocity = run_direction * RUN_SPEED * speed_multiplier

func _on_detection_area_body_entered(body):
	print("Turning Ghost Running")
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
	
