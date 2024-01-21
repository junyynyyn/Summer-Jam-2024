extends Control

@onready var Level1ProgBar = $GridContainer/ButtonLevel1/TextureProgressBar
var progressBar = null

func _ready():
	update_progress_bars()
	update_unlocked_levels()
	$StarCount.text = "%d/27" % [starcounttotal]

var starcounttotal: int

func update_progress_bars():
	for level in Global.level_times.keys():
		if level == "TestLevel2":
			progressBar = get_node("Button" + level + "/TextureProgressBar")
		else:
			progressBar = get_node("GridContainer/Button" + level + "/TextureProgressBar")
		progressBar.value = Global.level_stars[level]
		if progressBar.value >= 4:
			progressBar.texture_progress=ResourceLoader.load("res://Sprites/UI/3 Golden Stars.png")
		starcounttotal += Global.level_stars[level]
		if starcounttotal >= 28:
			$StarCount/TextureRect.texture = ResourceLoader.load("res://Sprites/UI/single gold star.png")
		#print(progressBar.value)
		
func update_unlocked_levels():
	for level in Global.level_times:
		# Handle current level's lock
		var current_level_lock_path = "/root/LevelSelect/GridContainer/ButtonLevel" + str(level) + "/LockedLevel" + str(level)
		var lock = get_node_or_null(current_level_lock_path)
		if lock:
			lock.visible = false  # Hide lock if level is in level_times (completed)

		# Handle next level's lock
		var next_level = str(int(level) + 1)
		var next_level_lock_path = "/root/LevelSelect/GridContainer/ButtonLevel" + next_level + "/LockedLevel" + next_level
		var next_lock = get_node_or_null(next_level_lock_path)
		if next_lock:
			next_lock.visible = false  # Hide next level's lock only if it's completed
