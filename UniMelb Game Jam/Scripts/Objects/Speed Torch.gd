extends StaticBody2D

func _on_speed_area_body_entered(body):
	if (body.is_in_group("Ghost")):
		body.edit_speed(1.5)

func _on_speed_area_body_exited(body):
	if (body.is_in_group("Ghost")):
		body.edit_speed(1.0)
