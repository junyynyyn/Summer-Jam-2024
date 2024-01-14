extends CharacterBody2D


@export var nav_agent: NavigationAgent2D
@export var speed = 2500
var home_pos = Vector2.ZERO
var target_node = null
var been_consumed = false
var is_moving = false

func _enter_tree():
	home_pos = self.global_position

func _physics_process(delta: float) -> void:
	if nav_agent.is_navigation_finished():
		return
	
	var axis = to_local(nav_agent.get_next_path_position()).normalized()
	var intended_velocity = axis * speed * delta
	nav_agent.set_velocity(intended_velocity)


func recalc_path():
	if target_node:
		nav_agent.target_position = target_node.global_position
		if nav_agent.target_position != home_pos:
			is_moving = true
	else:
		nav_agent.target_position = home_pos

func _on_path_recalc_timeout():
	recalc_path()


func _on_aggro_range_area_entered(area):
	var direction = (self.global_position - area.owner.global_position).normalized()
	var distance = 1000  # Adjust this value to control how far the enemy runs
	var new_target_position = self.global_position + direction * distance
	nav_agent.target_position = new_target_position
	is_moving = true

func _on_de_aggro_range_area_exited(area):
	if area.owner == target_node:
		target_node = null
		recalc_path()

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
