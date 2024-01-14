class_name Ghost extends CharacterBody2D

enum state {ROAMING, RUNNING, CAPTURED}

var capture_cooldown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func capture():
	if (not capture_cooldown):
		visible = false
	

func release():
	capture_cooldown = true
	$CaptureCooldownTimer.start()
	position = Global.player.position
	visible = true
	print("Released")

func _on_capture_cooldown_timer_timeout():
	capture_cooldown = false
