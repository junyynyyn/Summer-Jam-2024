extends StaticBody2D

var grappleable = true
var grapple_cooldown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (not grapple_cooldown and not grappleable):
		grapple_cooldown = true
		$HookCooldown.start()

func _on_hook_cooldown_timeout():
	grappleable = true
	grapple_cooldown = false
