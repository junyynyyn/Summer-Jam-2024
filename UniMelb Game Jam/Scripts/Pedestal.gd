extends StaticBody2D
var is_in_range = false
var item_already_grabbed = false
var teaching_player

func _ready():
	if Global.can_grapple:
		$Talisman.visible = false
		$Tooltip.visible = false

func _on_label_display_range_body_entered(body):
	if body.is_in_group("Player"):
		if not item_already_grabbed:
			is_in_range = true
			$Tooltip.visible = true

func _on_label_display_range_body_exited(body):
	if body.is_in_group("Player"):
		if not item_already_grabbed:
			is_in_range = false
			$Tooltip.visible = false

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_E and not item_already_grabbed:
			item_already_grabbed = true
			Global.can_grapple = true
			$AnimationPlayer.stop()
			$Talisman.queue_free()
			$Tooltip.visible = false
			
			teach_player()
			
			print(Global.can_grapple)
		if event.keycode == MOUSE_BUTTON_LEFT:
			if teaching_player == true:
				$LMBtoThrow.visible = false
				teaching_player = false

func teach_player():
	teaching_player = true
	$LMBtoThrow.visible = true
