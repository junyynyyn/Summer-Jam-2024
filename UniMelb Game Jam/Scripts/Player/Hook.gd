extends CharacterBody2D

var HOOK_SPEED : float = 500.0
var GRAPPLE_LENGTH : float = 200.0
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
		visible = false
		position = Global.player.position
	elif hook_state == state.FIRED:
		visible = true
		if is_on_wall() or is_on_ceiling() or is_on_floor():
			hook_state = state.UNFIRED
		if (position - Global.player.global_position).length() >= GRAPPLE_LENGTH:
			hook_state = state.UNFIRED
	elif hook_state == state.GRAPPLING:
		if (grappled_ghost):
			position = grappled_ghost.position
			Global.player.yeet()
		else:
			hook_state = state.UNFIRED
	move_and_slide()
	
func fire(direction: Vector2):
	hook_state = state.FIRED
	velocity = direction.normalized() * HOOK_SPEED

func _on_hook_hitbox_body_entered(body):
	if (hook_state == state.FIRED):
		velocity = Vector2.ZERO
		hook_state = state.GRAPPLING
		if (body.is_in_group("Ghost")):
			if (body.grappleable == true):
				grappled_ghost = body
				body.grappleable = false

func _on_detach_hitbox_body_entered(body):
	if (hook_state == state.GRAPPLING):
		if (body.is_in_group("Player")):
			hook_state = state.UNFIRED
			grappled_ghost = null
			Global.player.reverse_yeet()
		

func _on_hook_timer_timeout():
	if (hook_state == state.FIRED):
		hook_state = state.UNFIRED
		Global.player.set_hook_fire()
	
