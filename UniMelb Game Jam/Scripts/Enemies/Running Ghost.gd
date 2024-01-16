extends Ghost

var target_node = null
@onready var nav_agent := $Node2D/NavigationAgent2D as NavigationAgent2D

func _ready():
	super()
	RUN_SPEED = 75.0
	#home_pos = self.global_position
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4

func run():
	if nav_agent.is_navigation_finished():
		return
	if target_node:
		direction = (self.global_position - target_node.global_position).normalized()
		var distance = 50
		var new_target_position = self.global_position + direction * distance
		nav_agent.target_position = new_target_position
	var axis = to_local(nav_agent.get_next_path_position()).normalized()
	var intended_velocity = axis * RUN_SPEED * speed_multiplier
	velocity = intended_velocity

func update_sprite_orientation():
	if (Global.player):
		if Global.player.global_position.x < global_position.x:
			sprite.flip_h = true  # Player is to the left, flip sprite
		else:
			sprite.flip_h = false  # Player is to the right, don't flip

func recalc_path():
	if target_node:
		nav_agent.target_position = target_node.global_position
	else:
		#nav_agent.target_position = home_pos
		pass

func _on_path_recalc_timeout():
	recalc_path()

func _on_aggro_range_area_entered(area):
	ghost_state = state.RUNNING
	target_node = area.owner
	direction = (self.global_position - target_node.global_position).normalized()
	var distance = 50  # Adjust this value to control how far the enemy runs
	var new_target_position = self.global_position + direction * distance
	nav_agent.target_position = new_target_position
	#print("target acquired")
	#print(target_node)

func _on_aggro_range_area_exited(area):
	ghost_state = state.ROAMING
	if area.owner == target_node:
		target_node = null
		#print("target left")


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
	#print("computed")
