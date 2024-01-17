class_name MirroredGhost extends Ghost

func _ready():
	RUN_SPEED = 100.0

func run():
	#var input_dir = Input.get_vector("left", "right", "up", "down")
	#direction = (Vector2(input_dir.x, input_dir.y)).normalized()
	#
	#if direction:
		#velocity = direction * RUN_SPEED * speed_multiplier
	#else:
		#velocity = Vector2.ZERO
		
	velocity = Global.player.velocity * speed_multiplier
	
func _on_detection_area_body_entered(_body):
	ghost_state = state.RUNNING
	
func _on_detection_area_body_exited(_body):
	ghost_state = state.ROAMING
