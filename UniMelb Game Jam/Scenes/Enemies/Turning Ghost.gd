extends CharacterBody2D

var run_direction : Vector2 = Vector2(0,0)
@export var MAX_SPEED : float = 150.0
@export var ROAM_SPEED : float = 50.0
var speed : float = 20.0
var roam_target : Vector2 = Vector2(0,0)

enum state {ROAMING, RUNNING}

var ghost_state : state = state.ROAMING

func _ready():
	pass # Replace with function body.

func _process(_delta):
	if ghost_state == state.ROAMING:
		var direction = (position - roam_target).normalized()
		speed = lerp(speed, ROAM_SPEED, 0.5)
		velocity = direction * speed
	elif ghost_state == state.RUNNING:
		velocity.x = run_direction.x * MAX_SPEED
		velocity.y = run_direction.y * MAX_SPEED
	move_and_slide()

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

func _on_roam_timer_timeout():
	speed = ROAM_SPEED
	var rng = RandomNumberGenerator.new()
	roam_target.x = position.x + rng.randf_range(-10.0, 10.0)
	roam_target.y = position.y + rng.randf_range(-10.0, 10.0)
