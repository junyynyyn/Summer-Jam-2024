class_name Ghost extends CharacterBody2D

enum state {ROAMING, RUNNING, CAPTURED, ESCAPING}
var ghost_state : state = state.ROAMING

var speed_multiplier : float = 1.0

var capture_cooldown = false

# Base function to capture ghosts
func capture():
	if (not capture_cooldown):
		visible = false
		ghost_state = state.CAPTURED

# Base function to release ghosts from player captivity
func release():
	# Grants ghost 2 seconds of invulnerability to being captured again
	capture_cooldown = true
	$CaptureCooldownTimer.start()
	position = Global.player.position
	visible = true
	ghost_state = state.RUNNING

func _on_capture_cooldown_timer_timeout():
	capture_cooldown = false
	
func edit_speed(multiplier: float):
	speed_multiplier = multiplier
