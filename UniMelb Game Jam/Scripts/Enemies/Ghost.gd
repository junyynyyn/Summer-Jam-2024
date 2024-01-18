class_name Ghost extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var light = $Sprite2D/PointLight2D
@onready var player_collection_area = get_node("/root/Level/PlayerResources/Player/GhostCollectionArea")
@onready var player = get_node("/root/Level/PlayerResources/Player")

enum state {ROAMING, RUNNING, CAPTURED, ESCAPING}
var ghost_state : state = state.ROAMING

# Common values between ghosts
@export var ROAM_SPEED : float = 10.0
@export var RUN_SPEED : float = 150.0
var speed : float
var direction : Vector2
var speed_multiplier : float = 1.0

@export var ROAM_AREA : float = 10.0
var roam_target : Vector2 = Vector2(0,0)

var capture_cooldown = false
var grappleable = true

func _ready():
	pass

func _process(_delta):
	match ghost_state:
		state.ROAMING:
			roam()
		state.RUNNING:
			run()
		state.CAPTURED:
			pass
		state.ESCAPING:
			pass
	
	update_sprite_orientation()
	
	move_and_slide()
# ======================================================
# Capture Code
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
	
	var rng = RandomNumberGenerator.new()
	direction = Vector2(rng.randf_range(-1, 1),rng.randf_range(-1, 1))
	velocity = direction * 200
	
	ghost_state = state.ESCAPING
	
func _on_capture_cooldown_timer_timeout():
	capture_cooldown = false
	ghost_state = state.ROAMING
	grappleable = true

# ======================================================
# Movement and behaviour code
# Can be overridden in subclasses if required
func roam():
	direction = (position - roam_target).normalized()
	speed = lerp(speed, ROAM_SPEED, 0.5)
	velocity = direction * speed * speed_multiplier

func run():
	pass

func _on_roam_timer_timeout():
	#Reset speed
	speed = ROAM_SPEED
	#Randomize a target location for ghost to wander to during roam state
	var rng = RandomNumberGenerator.new()
	roam_target.x = position.x + rng.randf_range(-ROAM_AREA, ROAM_AREA)
	roam_target.y = position.y + rng.randf_range(-ROAM_AREA, ROAM_AREA)
	
func update_sprite_orientation():
	if (Global.player):
		if Global.player.global_position.x < global_position.x:
			sprite.flip_h = true  # Player is to the left, flip sprite
		else:
			sprite.flip_h = false  # Player is to the right, don't flip

func edit_speed(multiplier: float):
	speed_multiplier = multiplier
	
