extends Node

var timer : float = 0.0
var timer_active : bool = true

func _process(delta):
	$UI.update_ghost_count(Global.player.ghosts_collected.size())
	if (timer_active):
		timer += delta
	$UI.update_timer(timer)

func reset_timer():
	timer = 0

func pause_timer():
	timer_active = false
	
func start_timer():
	timer_active = true
