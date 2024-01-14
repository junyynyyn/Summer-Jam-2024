class_name Ghost extends CharacterBody2D

enum state {ROAMING, RUNNING, CAPTURED, ESCAPING}
var ghost_state : state = state.ROAMING

var capture_cooldown = false

func capture():
	if (not capture_cooldown):
		visible = false
		ghost_state = state.CAPTURED

func release():
	capture_cooldown = true
	$CaptureCooldownTimer.start()
	position = Global.player.position
	visible = true
	ghost_state = state.RUNNING

func _on_capture_cooldown_timer_timeout():
	capture_cooldown = false
