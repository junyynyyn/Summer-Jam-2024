extends Sprite2D

var is_in_range = false


func _on_label_display_range_body_entered(body):
	if body.is_in_group("Player"):
		is_in_range = true
		$Tooltip.visible = true


func _on_label_display_range_body_exited(body):
	if body.is_in_group("Player"):
		is_in_range = false
		$Tooltip.visible = false

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_E:
			Global.can_grapple = true
			print(Global.can_grapple)
