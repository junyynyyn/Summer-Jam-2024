extends StaticBody2D

var grappleable = true
var grapple_cooldown = false
@export var Light_Energy: float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	$PointLight2D.energy = Light_Energy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (not grapple_cooldown and not grappleable):
		grapple_cooldown = true
		$HookCooldown.start()

func _on_hook_cooldown_timeout():
	grappleable = true
	grapple_cooldown = false
