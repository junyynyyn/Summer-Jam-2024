class_name MirroredGhost extends Ghost

var speed: float = 150

@onready var sprite = $Sprite2D

func _ready():
	pass

func _process(_delta):
	# Movement Code
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (Vector2(input_dir.x, input_dir.y)).normalized()
	
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	# Flip the sprite based on player's position
	update_sprite_orientation()

	move_and_slide()

func update_sprite_orientation():
	if Global.player.global_position.x < global_position.x:
		sprite.flip_h = false  # Player is to the left, flip sprite
	else:
		sprite.flip_h = true  # Player is to the right, don't flip
