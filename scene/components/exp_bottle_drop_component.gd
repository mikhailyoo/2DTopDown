extends Node


@export_range(0, 1) var drop_percent: float = 0.3
@export var exp_bottle_scene: PackedScene
@export var health_component: Node


func _ready():
	(health_component as HealthComponent).died.connect(on_died)
	
	
func on_died ():
	var drop_upgrade = MetaProgression.get_upgrade_quantity("experience_drop_chance") * 0.1
	drop_percent += drop_upgrade
	if randf() > drop_percent:
		return
	
	if exp_bottle_scene == null:
		return
		
	if not owner is Node2D:
		return
		
	var spawn_pos = (owner as Node2D).global_position
	var exp_bottle_instance = exp_bottle_scene.instantiate() as Node2D
	var back_layer = get_tree().get_first_node_in_group("back_layer")
	back_layer.add_child(exp_bottle_instance)
	exp_bottle_instance.global_position = spawn_pos
