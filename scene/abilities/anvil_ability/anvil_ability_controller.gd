extends Node

@export var anvil_ability_scene: PackedScene
@export var anvil_damage: float = 15
@export var spawn_range: float = 100


func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (direction * randf_range(0, spawn_range))
	
	var raycast = PhysicsRayQueryParameters2D.create\
	(player.global_position, spawn_position, 1)
	var intersection = get_tree().root.world_2d.direct_space_state.intersect_ray(raycast)
	if !intersection.is_empty():
		spawn_position = intersection["position"]
	
	var anvil_ability_instance = anvil_ability_scene.instantiate()
	get_tree().get_first_node_in_group("front_layer").add_child(anvil_ability_instance)
	anvil_ability_instance.global_position = spawn_position
	anvil_ability_instance.hit_box_component.damage = anvil_damage
