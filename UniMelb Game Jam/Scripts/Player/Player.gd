extends CharacterBody2D

@export var SPEED : float = 150.0
@export var GRAPPLE_SPEED : float = 500.0
@export var DECELERATION : float = 10.0
@export var ACCELERATION : float = 25.0

@onready var timer = %ReleaseTimer
#@onready var GrappleThrowNoise = get_node("/root/Level/Audio/GrappleThrowNoise")
var ghosts_collected = []
var can_fire_hook = true

@onready var container = get_node("/root/Level/UI/GhostCounter/Container")

func _ready():
	#Allow global access to the player as a singleton
	Global.player = self

func _process(_delta):
	# Movement Code
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (Vector2(input_dir.x, input_dir.y)).normalized()
	if (velocity.length() <= 10.0):
		var cell = Global.tilemap.local_to_map(position)
		var data = Global.tilemap.get_cell_tile_data(0, cell)
		if (data.get_custom_data("Pit")):
			get_tree().reload_current_scene()
	
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, ACCELERATION)
		velocity.y = move_toward(velocity.y, direction.y * SPEED, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		velocity.y = move_toward(velocity.y, 0, DECELERATION)
	
	if (Input.is_action_just_pressed("fire")):
		var mouse_pos = get_global_mouse_position()
		var mouse_direction = Global.hook.global_position.direction_to(mouse_pos)
		Global.hook.fire(mouse_direction)
		#GrappleThrowNoise.play()
		can_fire_hook = false
		
	# If ghosts are collected then drag them along with the player
	if (ghosts_collected):
		for ghosts in ghosts_collected:
			ghosts.position = position
			
	if ($GhostCollectionArea.has_overlapping_bodies()):
		for ghost in $GhostCollectionArea.get_overlapping_bodies():
			capture_ghost(ghost)
	
	move_and_slide()
	
func set_hook_fire():
	can_fire_hook = true

func yeet():
	set_collision_mask_value(6, false)
	var hook_position = Global.hook.global_position
	var direction = position.direction_to(hook_position)
	velocity = direction * GRAPPLE_SPEED
	
func reverse_yeet():
	velocity = -velocity.normalized() * 150.0

# Collect ghosts if they enter the collection area
func _on_ghost_collection_area_body_entered(body):
	if (body.is_in_group("Ghost")):
		var ghost = body
		capture_ghost(ghost)

#New Function to allow catching ghosts who dont leave player zone
func capture_ghost(ghost):
	if (ghost not in ghosts_collected and ghost.capture_cooldown == false):
		ghost.capture()
		ghosts_collected.append(ghost)
		add_ghost_to_ui(ghost)  # Assuming the ghost's Texture is accessible via a property 'sprite'
		timer.start()

# When timer is over release all the ghosts
func _on_release_timer_timeout():
	for ghosts in ghosts_collected:
		ghosts.release()
	ghosts_collected.clear()
	for ghosts in container.get_children():
		ghosts.queue_free()



func add_ghost_to_ui(ghost):
	var texture_rect = TextureRect.new()
	if ghost.name == "Mirrored Ghost":
		texture_rect.texture = load("res://Sprites/Ghosts/WispGreen1stFrame.png")
	elif ghost.name == "Turning Ghost":
		texture_rect.texture = load("res://Sprites/Ghosts/WispBlue1stFrame.png")
	elif ghost.name == "Running Ghost":
		texture_rect.texture = load("res://Sprites/Ghosts/WispRed1stFrame.png")
	elif ghost.name == "Vanishing Ghost":
		texture_rect.texture = load("res://Sprites/Ghosts/WispGrey1stFrame.png")
	elif ghost.name == "Teleporting Ghost":
		texture_rect.texture = load("res://Sprites/Ghosts/WispPurple1stFrame.png")
	elif ghost.name == "Tutorial Ghost":
		texture_rect.texture = load("res://Sprites/ghost.png")
	#else:
		#print("Missing Ghost Texture")
	texture_rect.size = Vector2(10, 10)
	container.add_child(texture_rect)
