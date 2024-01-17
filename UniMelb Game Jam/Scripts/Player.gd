extends CharacterBody2D

@export var SPEED : float = 100.0

@onready var timer = %ReleaseTimer

var ghost = null
var ghosts_collected = []

func _ready():
	#Allow global access to the player as a singleton
	Global.player = self

func _process(_delta):
	# Movement Code
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (Vector2(input_dir.x, input_dir.y)).normalized()
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
		
	# If ghosts are collected then drag them along with the player
	if (ghosts_collected):
		for ghost in ghosts_collected:
			ghost.position = position
		
	move_and_slide()

# Collect ghosts if they enter the collection area
func _on_ghost_collection_area_body_entered(body):
	if (body.is_in_group("Ghost")):
		ghost = body
		capture_ghost()

#New Function to allow catching ghosts who dont leave player zone
func capture_ghost():
	if (ghost not in ghosts_collected and ghost.capture_cooldown == false):
		ghost.capture()
		ghosts_collected.append(ghost)
		#Restart timer 
		timer.start()
		ghost = null

# When timer is over release all the ghosts
func _on_release_timer_timeout():
	for ghost in ghosts_collected:
		ghost.release()
	ghosts_collected.clear()
