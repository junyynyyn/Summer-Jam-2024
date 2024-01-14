extends CharacterBody2D

@export var SPEED : float = 75.0
@export var DECELERATION : float = 25.0

var ghosts_collected = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _input(_event):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var input_dir = Input.get_vector("left", "right", "up", "down")
	
	var direction = (Vector2(input_dir.x, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity = Vector2(0,0)
		
	move_and_slide()
