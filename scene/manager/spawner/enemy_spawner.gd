extends Node


@export var mushroom_scene: PackedScene


func _on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var random_distance = randi_range(380, 500)
	var spawn_pos = player.global_position + (random_direction * random_distance)
	
	
	var enemy = mushroom_scene.instantiate() as Node2D
	var back_layer = get_tree().get_first_node_in_group("back_layer")
	back_layer.add_child(enemy)
	
	enemy.global_position = spawn_pos
