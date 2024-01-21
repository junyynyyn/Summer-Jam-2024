class_name Teleporter extends Area2D

@export var target_teleporter : Teleporter

@onready var marker = $TeleportPoint
@onready var timer = $TeleportCooldown

var teleporter_cooldown = false

func _on_body_entered(body):
	if (not teleporter_cooldown):
		teleport(body)
		TeleportNoise.play()
	
func teleport(body):
	if (target_teleporter):
		body.position = target_teleporter.marker.global_position
		target_teleporter.teleporter_cooldown = true
		target_teleporter.timer.start()

func _on_teleport_cooldown_timeout():
	teleporter_cooldown = false
