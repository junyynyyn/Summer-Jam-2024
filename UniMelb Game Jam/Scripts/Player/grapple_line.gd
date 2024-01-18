extends Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.1).timeout
	Global.line = self
	add_point(Global.hook.global_position)
	add_point(Global.player.global_position)
	
func _process(_delta):
	if Global.can_grapple:
		self.modulate = Color(1, 1, 1, 1)
		if (Global.hook.visible == false):
			visible = false
		else:
			visible = true
		if points:
			set_point_position(0, Global.player.global_position)
			set_point_position(1, Global.hook.global_position)
	else:
		self.modulate = Color(1, 1, 1, 0)
