extends CanvasLayer


func change_scene(target: String) -> void:
	var current_scene = get_node("/root/")
	$AnimationPlayer.play('dissolve')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("dissolve")
