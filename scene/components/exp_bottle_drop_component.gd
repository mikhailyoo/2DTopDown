extends Node


@export var drop_percent = .5
@export var exp_bottle_scene: PackedScene
@export var health_component: Node


func _ready():
	(health_component as HealthComponent).died.connect(on_died)
	
	
func on_died ():
	if randf() < drop_percent:
		return
	
	if exp_bottle_scene == null:
		return
		
	if not owner is Node2D:
		return
		
	var spawn_pos = (owner as Node2D).global_position
	var exp_bottle_instance = exp_bottle_scene.instantiate() as Node2D
	owner.get_parent().add_child(exp_bottle_instance)
	exp_bottle_instance.global_position = spawn_pos
