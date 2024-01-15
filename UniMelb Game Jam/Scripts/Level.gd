extends Node2D

@export var ghost_quota : int
@export var next_level : PackedScene

var ghost_total : int

var timer : float = 0.0
var timer_active : bool = true
var goal : bool = false

func _ready():
	ghost_total = $Ghosts.get_child_count()

func _process(delta):
	$UI.update_ghost_count(Global.player.ghosts_collected.size())
	if (timer_active):
		timer += delta
	$UI.update_timer(timer)
	
	if (Global.player.ghosts_collected.size() >= ghost_quota):
		complete_level()
	
func reset_timer():
	timer = 0

func pause_timer():
	timer_active = false
	
func start_timer():
	timer_active = true
	
func complete_level():
	$UI.display_finish(timer)
	get_tree().paused = true
	
func _on_ui_next_scene():
	if next_level:
		get_tree().change_scene_to_packed(next_level)
