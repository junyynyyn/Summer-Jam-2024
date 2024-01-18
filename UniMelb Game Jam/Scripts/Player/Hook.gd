extends CharacterBody2D

@onready var GrappleThrowNoise = $Audio/GrappleThrowNoise

var HOOK_SPEED : float = 500.0
var GRAPPLE_LENGTH : float = 250.0
var fired : bool = false
enum state {UNFIRED, FIRED, GRAPPLING}
var hook_state : state
var grappled_ghost : Ghost

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.hook = self
	hook_state = state.UNFIRED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if hook_state == state.UNFIRED:
		GrappleThrowNoise.play()
		visible = false
		position = Global.player.position
		Global.player.set_collision_mask_value(6, true)
	elif hook_state == state.FIRED:
		visible = true
		if is_on_wall() or is_on_ceiling() or is_on_floor():
			hook_state = state.UNFIRED
		if (position - Global.player.global_position).length() >= GRAPPLE_LENGTH:
			hook_state = state.UNFIRED
	elif hook_state == state.GRAPPLING:
		var bodies = $DetachHitbox.get_overlapping_bodies()
		for body in bodies:
			if (body.is_in_group("Player")):
				hook_state = state.UNFIRED
				grappled_ghost.grappleable = false
				grappled_ghost = null
				Global.player.reverse_yeet()
		if (grappled_ghost):
			if (grappled_ghost.grappleable == true):
				position = grappled_ghost.position
				Global.player.yeet()
		else:
			hook_state = state.UNFIRED
	move_and_slide()
	
func fire(direction: Vector2):
	rotation = (direction.angle() + PI/2)
	hook_state = state.FIRED
	velocity = direction.normalized() * HOOK_SPEED

func _on_hook_hitbox_body_entered(body):
	if (hook_state == state.FIRED):
		if (body.is_in_group("Ghost")):
			if (body.grappleable == true):
				velocity = Vector2.ZERO
				hook_state = state.GRAPPLING
				grappled_ghost = body

func _on_hook_timer_timeout():
	if (hook_state == state.FIRED):
		hook_state = state.UNFIRED
		Global.player.set_hook_fire()
