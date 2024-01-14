extends Ghost

var health = 200
var damage = 5
@export var speed = 3000

var health_bar: TextureProgressBar
var is_dead = false
#var home_pos = Vector2.ZERO
var target_node = null
@onready var nav_agent := $Node2D/NavigationAgent2D as NavigationAgent2D

#func _enter_tree():
	#home_pos = self.global_position

func _ready():
	#home_pos = self.global_position
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4


func _physics_process(delta: float) -> void:
	if nav_agent.is_navigation_finished():
		return
	if target_node:
		var direction = (self.global_position - target_node.global_position).normalized()
		var distance = 50
		var new_target_position = self.global_position + direction * distance
		nav_agent.target_position = new_target_position
	var axis = to_local(nav_agent.get_next_path_position()).normalized()
	var intended_velocity = axis * speed * delta
	velocity = intended_velocity
	move_and_slide()

func recalc_path():
	if target_node:
		nav_agent.target_position = target_node.global_position
	else:
		#nav_agent.target_position = home_pos
		pass


func _on_path_recalc_timeout():
	recalc_path()


func _on_aggro_range_area_entered(area):
	target_node = area.owner
	var direction = (self.global_position - target_node.global_position).normalized()
	var distance = 50  # Adjust this value to control how far the enemy runs
	var new_target_position = self.global_position + direction * distance
	nav_agent.target_position = new_target_position
	print("target acquired")
	print(target_node)

func _on_aggro_range_area_exited(area):
	if area.owner == target_node:
		target_node = null
		print("target left")


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
	print("computed")
