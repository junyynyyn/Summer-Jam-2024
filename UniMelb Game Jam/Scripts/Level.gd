extends Node2D

@export var ghost_quota : int
@export var next_level : PackedScene

var ghost_total : int

var timer : float = 0.0
var timer_active : bool = true
var goal : bool = false

func _ready():
	#Get total ghost count and send to UI
	ghost_total = $Ghosts.get_child_count()
	$UI.set_ghost_count_max(ghost_total)

func _process(delta):
	# Get current ghost count from player and send to UI, also update timer 
	$UI.update_ghost_count(Global.player.ghosts_collected.size())
	if (timer_active):
		timer += delta
	$UI.update_timer(timer)
	
	# Check if player has hit the ghost collected to finish the level
	if (Global.player.ghosts_collected.size() >= ghost_quota):
		complete_level()
	
func reset_timer():
	timer = 0

func pause_timer():
	timer_active = false
	
func start_timer():
	timer_active = true

# Show end screen UI and pause game functionaltiy besides UI
func complete_level():
	$UI.display_finish(timer)
	$"UI/Timer Grid".visible = false
	get_tree().paused = true
	
func _on_ui_next_scene():
	if next_level:
		get_tree().change_scene_to_packed(next_level)
