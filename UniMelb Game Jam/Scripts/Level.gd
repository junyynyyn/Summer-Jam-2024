extends Node2D

@export var level_name = ""
@export var ghost_quota : int
@export var next_level : PackedScene

var OneStar: float = 99999
@export var TwoStar : float = 0 
@export var ThreeStar : float = 0
@export var Gold : float = 0

@onready var four_star = get_node("/root/Level/UI/FinishScreen/Star Ratings/4 Star/4StarText")
@onready var three_star = get_node("/root/Level/UI/FinishScreen/Star Ratings/3 Star/3StarText")
@onready var two_star = get_node("/root/Level/UI/FinishScreen/Star Ratings/2 Star/2StarText")

var ghost_total : int

var timer : float = 0.0
var timer_active : bool = true
var goal : bool = false

var can_teleport = true
var stars = 0

func _ready():
	#Get total ghost count and send to UI
	ghost_total = $Ghosts.get_child_count()
	$UI.set_ghost_count_max(ghost_total)
	adjust_star_thresholds()

	#if get_tree().get_current_scene().is_in_group("Level1"):
		#print("You are on Level 1")

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
	reward_stars()
	var new_best = false
	if level_name not in Global.level_times or timer < Global.level_times[level_name]:
		new_best = true
	$UI.display_finish(timer, level_name, new_best)
	$"UI/Timer Grid".visible = false
	get_tree().paused = true
	
	reward_stars()
	update_best_time_and_stars()
	Global.save_game_data()

	#print("You completed ", level_name, " in ", timer, " seconds")

func update_best_time_and_stars():
	# Update time
	if level_name not in Global.level_times or timer < Global.level_times[level_name]:
		Global.level_times[level_name] = timer
	
	# Update stars
	var new_stars = reward_stars()  # Assuming reward_stars returns the number of stars
	if level_name not in Global.level_stars or new_stars > Global.level_stars[level_name]:
		Global.level_stars[level_name] = new_stars

func reward_stars():
	if timer <= Gold:
		stars = 4
	elif (Gold < timer and timer <= ThreeStar):
		stars = 3
	elif (ThreeStar < timer and timer <= TwoStar):
		stars = 2
	elif (TwoStar < timer and timer <= OneStar):
		stars = 1
	$UI.reward_stars(stars)  # Update UI with star rating
	return stars

func _on_ui_next_scene():
	if next_level:
		get_tree().change_scene_to_packed(next_level)

func adjust_star_thresholds():
	
	four_star.text = "%.2f" % Gold
	three_star.text = "%.2f" % ThreeStar
	two_star.text = "%.2f" % TwoStar

